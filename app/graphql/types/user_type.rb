# frozen_string_literal: true
module Types
  class UserType < BaseObject
    field :id, ID, null: false
    field :uid, ID, null: false
    field :name, String, null: true
    field :nickname, String, null: true
  end
end
