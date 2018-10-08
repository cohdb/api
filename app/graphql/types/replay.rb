# frozen_string_literal: true
class Types::Replay < Types::BaseObject
  field :id, ID, null: false
  field :user, Types::User, null: true
  field :version, Int, null: false
  field :length, Int, null: false
  field :map_name, String, null: false
  field :url, String, null: true
  field :players, [Types::Player], null: false
end
