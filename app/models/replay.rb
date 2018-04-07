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
#
# Indexes
#
#  index_replays_on_user_id  (user_id)
#

class Replay < ApplicationRecord
  include Vault

  OPPONENT_TYPES = %w(human cpu).freeze
  GAME_TYPES = %w(COH2_REC).freeze

  belongs_to :user, optional: true

  has_many :players
  has_many :commands, through: :players
  has_many :chat_messages, through: :players

  has_attached_file :rec

  validates_attachment :rec, presence: true,
                             content_type: { content_type: ['application/octet-stream'] },
                             size: { less_than: 25.megabytes }

  validates :opponent_type, presence: true, inclusion: { in: OPPONENT_TYPES }
  validates :game_type, presence: true, inclusion: { in: GAME_TYPES }
  validates :map, presence: true
  validates :recorded_at, presence: true
  validates :version, numericality: { only_integer: true, greater_than: 0 }

  def map_resource_id
    map.delete('$')
  end

  def map_name
    Relic::Resources::Collection.resource_text(map_resource_id, :english) || 'Unknown'
  end

  def url
    rec&.url
  end

  def self.create_from_file(params)
    ptr = Vault.parse_to_cstring(params[:rec].path)
    replay_json = JSON.parse(ptr.read_string)
    Vault.free_cstring(ptr)

    Replay.create_from_json(replay_json, params[:user_id], params[:rec])
  end

  def self.create_from_json(json, user, rec)
    replay = []
    players = []
    ActiveRecord::Base.transaction do
      recorded_at = begin
                      json['date_time'].to_datetime
                    rescue
                      nil
                    end

      replay = Replay.create!(user_id: user,
                              version: json['version'],
                              length: json['duration'],
                              map: json['map']['name'],
                              rng_seed: json['rng_seed'],
                              opponent_type: OPPONENT_TYPES[json['opponent_type'] - 1],
                              game_type: json['game_type'],
                              recorded_at: recorded_at,
                              rec: rec)

      players = Player.create_from_json(replay, json)
    end

    [replay, players]
  end
end
