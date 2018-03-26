class Player < ApplicationRecord
  MAX_ENTITY_ID = 2_147_483_647

  belongs_to :replay
  has_many :commands, -> { order(:tick) }
  has_many :chat_messages, -> { order(:tick) }

  scope :for_replay, ->(replay) { replay.nil? ? all : where(replay: replay) }

  def commander_name
    Relic::Attributes::Commanders.to_localized_string(commander, :english) || 'Unknown'
  end

  def steam_avatar_url_cache_key
    "steam_id/#{steam_id}/steam_avatar_url"
  end

  def steam_avatar_url
    Rails.cache.fetch(steam_avatar_url_cache_key) do
      Steam::User.summary(steam_id)['avatar']
    end
  rescue
    nil
  end

  class << self
    def create_from_json(replay, json)
      players = []

      ActiveRecord::Base.transaction do
        conn = ActiveRecord::Base.connection
        commands = []
        messages = []

        json['players'].each do |p_json|
          player = Player.create!(replay: replay,
                                  internal_id: p_json['id'],
                                  steam_id: p_json['steam_id_str'],
                                  name: p_json['name'],
                                  team: p_json['team'],
                                  faction: p_json['faction'],
                                  commander: p_json['commander'].to_s,
                                  cpm: p_json['cpm'])

          player_commands = json['commands'][p_json['id'].to_s]&.map do |command|
            "(#{player.id},#{command['player_id']},#{command['tick']},'#{command['command_type']}',#{command['entity_id']},#{command['x']},#{command['y']},#{command['z']},CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)" unless command['entity_id'].to_i > MAX_ENTITY_ID
          end

          commands += player_commands.compact if player_commands

          messages += json['chat'].select { |msg| msg['name'] == player.name }.map do |msg|
            "(#{player.id},#{msg['tick']},#{conn.quote(msg['message'])},CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)"
          end

          players << player
        end

        conn.execute("INSERT INTO commands (player_id,internal_player_id,tick,command_type,entity_id,x,y,z,created_at,updated_at) VALUES #{commands.join(',')}") unless commands.empty?
        conn.execute("INSERT INTO chat_messages (player_id,tick,message,created_at,updated_at) VALUES #{messages.join(',')}") unless messages.empty?
      end

      players
    end

    def steam_avatar_url_cache_key(steam_id)
      "steam_id/#{steam_id}/steam_avatar_url"
    end

    def load_steam_avatar_urls(players)
      unloaded_ids = players.select { |player| Rails.cache.fetch(player.steam_avatar_url_cache_key).nil? }.map(&:steam_id)
      Steam::User.summaries(unloaded_ids).each do |summary|
        Rails.cache.write(steam_avatar_url_cache_key(summary['steamid']), summary['avatar'])
      end
    rescue
      nil
    end
  end
end
