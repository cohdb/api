# frozen_string_literal: true
class Types::Mutation < Types::BaseObject
  field :create_replay, mutation: Mutations::CreateReplay
end
