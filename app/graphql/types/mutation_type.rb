# frozen_string_literal: true
class Types::MutationType < Types::BaseObject
  field :create_replay, mutation: Mutations::CreateReplay
end
