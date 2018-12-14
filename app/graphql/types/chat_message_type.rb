# frozen_string_literal: true
module Types
  class ChatMessageType < BaseObject
    field :id, ID, null: false
    field :player_id, ID, null: false
    field :player, PlayerType, null: false
    field :tick, Int, null: false
    field :message, String, null: true
  end
end
