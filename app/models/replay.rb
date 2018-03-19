class Replay < ApplicationRecord
  include Vault

  OPPONENT_TYPES = %w(human cpu).freeze

  belongs_to :user, optional: true
  has_many :players
  has_many :commands, through: :players
  has_many :chat_messages, through: :players

  has_attached_file :rec

  validates_attachment :rec, content_type: { content_type: ['application/octet-stream'] },
                             size: { less_than: 25.megabytes }

  def map_resource_id
    map.delete('$')
  end

  def map_name
    Relic::Resources::Collection.resource_text(map_resource_id, :english)
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

      replay = Replay.create!(user: user,
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
