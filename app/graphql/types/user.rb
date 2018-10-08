# frozen_string_literal: true
module Types
  class User < BaseObject
    field :id, ID, null: false
    field :email, String, null: false
  end
end
