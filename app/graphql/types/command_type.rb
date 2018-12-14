# frozen_string_literal: true
module Types
  class CommandType < BaseObject
    field :id, ID, null: false
    field :player_id, ID, null: false
    field :player, PlayerType, null: false
    field :tick, Int, null: false
    field :entity_name, String, null: true
    field :command_category, String, null: true
    field :command_text, String, null: true
    field :x, Float, null: true
    field :y, Float, null: true
    field :z, Float, null: true
  end
end
