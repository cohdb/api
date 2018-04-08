# frozen_string_literal: true
# == Schema Information
#
# Table name: replays
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  version          :integer          not null
#  length           :integer          not null
#  map              :string           not null
#  rng_seed         :integer
#  opponent_type    :string
#  game_type        :string
#  recorded_at      :datetime
#  rec_file_name    :string
#  rec_content_type :string
#  rec_file_size    :integer
#  rec_updated_at   :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recorded_at_text :string           default(""), not null
#
# Indexes
#
#  index_replays_on_user_id  (user_id)
#

class Replay < ApplicationRecord
  include Vault

  OPPONENT_TYPES = %w[human cpu].freeze
  GAME_TYPES = %w[COH2_REC].freeze

  belongs_to :user, optional: true

  has_many :players, dependent: :destroy
  has_many :commands, through: :players
  has_many :chat_messages, through: :players

  has_attached_file :rec

  validates_attachment :rec, presence: true,
                             content_type: { content_type: ['application/octet-stream'] },
                             size: { less_than: 25.megabytes }

  validates :opponent_type, presence: true, inclusion: { in: OPPONENT_TYPES }
  validates :game_type, presence: true, inclusion: { in: GAME_TYPES }
  validates :map, presence: true
  validates :recorded_at_text, presence: true
  validates :version, numericality: { only_integer: true, greater_than: 0 }
  validates :length, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :for_user, ->(user) { user.nil? ? all : where(user: user) }
  scope :after, ->(id) { id.nil? ? all : where('id < ?', id) }

  SEPARATOR = '|'

  scope :filter, lambda { |params|
    cursor = params[:cursor]

    if cursor
      raise '400 Bad Request' if params.keys.any? { |name| column_names.include?(name.to_s) }
      cursor_data = decode_cursor(cursor)
      params = cursor_data[:filters]
    end

    scope = all
    params.each do |name, value|
      scope = scope.where(name => value) if column_names.include?(name.to_s)
    end
    scope
  }

  scope :order_by, lambda { |params|
    cursor = params[:cursor]
    orders = params[:order_by] || ''

    if cursor
      raise '400 Bad Request' if params.key?(:order_by)
      cursor_data = decode_cursor(cursor)
      cursors = cursor_data[:cursors]
    else
      cursors = orders.split(',').map do |element|
        field, direction = element.split(SEPARATOR)
        { field: field, direction: direction || 'asc' }
      end
    end

    scope = all
    cursors.each do |element|
      scope = scope.order(element[:field] => element[:direction])
    end

    scope = scope.order(id: :desc) unless cursors.any? { |c| c[:field] == 'id' }

    scope
  }

  scope :page, lambda { |params|
    cursor = params[:cursor]
    limit = params[:limit]

    scope = all

    if cursor
      cursor_data = decode_cursor(cursor)
      limit ||= cursor_data[:limit]
      cursors = cursor_data[:cursors]

      previous = []
      query = ''

      cursors.each do |element|
        operator = element[:direction] == 'asc' ? '>' : '<'
        query += if previous.empty?
                   sanitize_sql_array(["#{element[:field]} #{operator} ? ", element[:value]])
                 else
                   sanitize_sql_array(["OR (#{generate_sub_query(previous)} AND #{element[:field]} #{operator} ?) ",
                                       element[:value]])
                 end

        previous << element
      end

      byebug
      scope = scope.where(query).limit(limit)
    else
      limit ||= 25
      scope = scope.limit(limit)
    end

    scope
  }

  def self.generate_sub_query(previous_cursors)
    previous_cursors.map do |cursor|
      sanitize_sql_array(["#{cursor[:field]} = ?", cursor[:value]])
    end.join(' AND ')
  end

  def self.decode_cursor(cursor)
    decoded_cursor = Base64.decode64(cursor)
    elements = decoded_cursor.split(',')

    elements.each_with_object(filters: {}, cursors: [], limit: 25) do |element, acc|
      field, value, direction = element.split(SEPARATOR)
      next unless field == 'limit' || column_names.include?(field)
      if field == 'limit'
        acc[:limit] = value
      elsif direction.nil?
        acc[:filters][field] = value
      else
        acc[:cursors] << { field: field, value: value, direction: direction }
      end
    end
  end

  def self.format_field(field, value)
    column = columns.select { |column| column.name == field.to_s }.first
    return unless column


  end

  # scope :page, lambda do |params|
  #   return all if params[:cursor].nil?
  #
  #   ordering = decode_order(params[:order])
  #
  # end

  # params[:cursor] = 'id:1:desc,version:100:desc,user_id:1'

  # params[:order] = 'version:desc'
  #
  # def decode_order(order)
  #   return {} if order.nil?
  #   Base64.decode64(order).split(',')
  #         .each_with_object({}) do |str, acc|
  #     field, direction = str.split(':')
  #     acc[field] = direction&.downcase || 'asc'
  #   end
  # end

  def map_resource_id
    map.delete('$')
  end

  def map_name
    Relic::Resources::Collection.resource_text(map_resource_id, :english) || 'Unknown'
  end

  def url
    rec&.url
  end

  class << self
    def create_from_file(params)
      ptr = Vault.parse_to_cstring(params[:rec].path)
      replay_json = JSON.parse(ptr.read_string)
      Vault.free_cstring(ptr)

      Replay.create_from_json(replay_json, params[:user_id], params[:rec])
    end

    def create_from_json(json, user, rec)
      replay = nil
      players = []
      ActiveRecord::Base.transaction do
        replay = json_replay_create(json, user, rec)
        players = Player.create_from_json(replay, json)
      end

      [replay, players]
    end

    private

    def json_replay_create(json, user, rec)
      Replay.create!(user_id: user,
                     version: json['version'],
                     length: json['duration'],
                     map: json['map']['name'],
                     rng_seed: json['rng_seed'],
                     opponent_type: OPPONENT_TYPES[json['opponent_type'] - 1],
                     game_type: json['game_type'],
                     recorded_at: parse_datetime_from_json(json),
                     recorded_at_text: json['date_time'],
                     rec: rec)
    end

    def parse_datetime_from_json(json)
      json['date_time'].to_datetime
    rescue StandardError
      nil
    end
  end
end
