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

  validates_attachment :rec, presence: true, size: { less_than: 25.megabytes }
  do_not_validate_attachment_file_type :rec

  validates :opponent_type, presence: true, inclusion: { in: OPPONENT_TYPES }
  validates :game_type, presence: true, inclusion: { in: GAME_TYPES }
  validates :map, presence: true
  validates :recorded_at_text, presence: true
  validates :version, numericality: { only_integer: true, greater_than: 0 }
  validates :length, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
