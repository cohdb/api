# frozen_string_literal: true
module Mutations
  class CreateReplay < Base
    argument :user_id, ID, required: false

    field :replay, Types::Replay, null: false

    description 'Create a `Replay` from file, optionally assigned to a `User`'

    def resolve(user_id:)
      user = user_id.nil? ? nil : User.find(user_id)
      json = ReplayService.new(context[:file]).to_json
      replay = Replay.create_from_json(json, user, context[:file])

      { replay: replay }
    end
  end
end
