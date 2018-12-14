# frozen_string_literal: true
module Types
  class ReplayType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: true
    field :version, Int, null: false
    field :length, Int, null: false
    field :map_name, String, null: false
    field :url, String, null: true
    field :players, [PlayerType], null: false
    field :chat_messages, [ChatMessageType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    field :commands, [CommandType], null: false do
      argument :player_id, ID, required: false
    end

    def commands(player_id:)
      object.commands.for_player(player_id)
    end
  end
end
