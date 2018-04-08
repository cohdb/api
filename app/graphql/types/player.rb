# frozen_string_literal: true
class Types::Player < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
end
