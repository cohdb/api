# frozen_string_literal: true
module Types
  class PlayerType < BaseObject
    field :id, ID, null: false
    field :replay, ReplayType, null: false
    field :name, String, null: false
    field :steam_id, ID, null: false
    field :faction, String, null: false
    field :team, Int, null: true
    field :commander_name, String, null: false
    field :cpm, Float, null: true
    field :commands, [CommandType], null: false
    field :chat_messages, [ChatMessageType], null: false
  end
end
