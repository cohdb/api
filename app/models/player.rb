# frozen_string_literal: true
# == Schema Information
#
# Table name: players
#
#  id          :integer          not null, primary key
#  replay_id   :integer          not null
#  internal_id :integer          not null
#  name        :string           not null
#  steam_id    :string           not null
#  faction     :string           not null
#  team        :integer
#  commander   :string
#  cpm         :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_players_on_replay_id  (replay_id)
#

# rubocop:disable Metrics/ClassLength
class Player < ApplicationRecord
  MAX_ENTITY_ID = 2_147_483_647
  FACTIONS = %w[soviet aef british german west_german].freeze

  belongs_to :replay
  has_many :commands, -> { order(:tick) }, inverse_of: :player
  has_many :chat_messages, -> { order(:tick) }, inverse_of: :player

  validates :internal_id, numericality: { only_integer: true }
  validates :name, presence: true
  validates :steam_id, presence: true
  validates :faction, presence: true, inclusion: { in: FACTIONS }

  scope :for_replay, ->(replay) { replay.nil? ? all : where(replay: replay) }

  def commander_name
    return 'Not Chosen' if commander.to_i.zero?
    Relic::Attributes::Commanders.to_localized_string(commander, :english)
  end

  def steam_avatar_url_cache_key
    "steam_id/#{steam_id}/steam_avatar_url"
  end

  def steam_avatar_url
    Rails.cache.fetch(steam_avatar_url_cache_key) do
      Steam::User.summary(steam_id)['avatar']
    end
  rescue StandardError
    nil
  end

  class << self
    def create_from_json(replay, json)
      results = { players: [] }

      ActiveRecord::Base.transaction do
        results = json['players'].each_with_object(players: [], commands: [], messages: []) do |p_json, acc|
          player = json_create_player(p_json, replay)
          acc[:players] << player
          acc[:commands] += json_extract_commands(json, p_json, player)
          acc[:messages] += json_extract_chat_messages(json, player)
        end

        insert_commands(results[:commands])
        insert_chat_messages(results[:messages])
      end

      results[:players]
    end

    def steam_avatar_url_cache_key(steam_id)
      "steam_id/#{steam_id}/steam_avatar_url"
    end

    def load_steam_avatar_urls(players)
      unloaded_ids = players.select { |player| Rails.cache.fetch(player.steam_avatar_url_cache_key).nil? }
                            .map(&:steam_id)
      Steam::User.summaries(unloaded_ids).each do |summary|
        Rails.cache.write(steam_avatar_url_cache_key(summary['steamid']), summary['avatar'])
      end
    rescue StandardError
      nil
    end

    private

    def json_create_player(player_json, replay)
      Player.create!(replay: replay,
                     internal_id: player_json['id'],
                     steam_id: player_json['steam_id_str'],
                     name: player_json['name'],
                     team: player_json['team'],
                     faction: player_json['faction'],
                     commander: player_json['commander'].to_s,
                     cpm: player_json['cpm'])
    end

    def json_extract_commands(replay_json, player_json, player)
      command_json = replay_json['commands'][player_json['id'].to_s] || []
      command_json.map do |command|
        next if command['entity_id'].to_i > MAX_ENTITY_ID
        <<-SQL.squish
          (
            #{player.id},
            #{command['player_id']},
            #{command['tick']},
            '#{command['command_type']}',
            #{command['entity_id']},
            #{command['x']},
            #{command['y']},
            #{command['z']},
            CURRENT_TIMESTAMP,
            CURRENT_TIMESTAMP
          )
        SQL
      end.compact
    end

    def json_extract_chat_messages(replay_json, player)
      replay_json['chat'].select { |msg| msg['name'] == player.name }
                         .map do |msg|
        <<-SQL.squish
          (
            #{player.id},
            #{msg['tick']},
            #{ActiveRecord::Base.connection.quote(msg['message'])},
            CURRENT_TIMESTAMP,
            CURRENT_TIMESTAMP
          )
        SQL
      end
    end

    def insert_commands(commands)
      return if commands.empty?
      ActiveRecord::Base.connection.execute(<<-SQL.squish)
        INSERT INTO
          commands(
            player_id, internal_player_id, tick, command_type, entity_id, x, y, z, created_at, updated_at
          )
        VALUES
          #{commands.join(',')}
      SQL
    end

    def insert_chat_messages(messages)
      return if messages.empty?
      ActiveRecord::Base.connection.execute(<<-SQL.squish)
        INSERT INTO
          chat_messages(
            player_id, tick, message, created_at, updated_at
          )
        VALUES
          #{messages.join(',')}
      SQL
    end
  end
end
# rubocop:enable Metrics/ClassLength
