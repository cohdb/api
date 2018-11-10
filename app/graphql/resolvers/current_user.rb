# frozen_string_literal: true
module Resolvers
  class CurrentUser < Base
    type Types::UserType, null: true

    description 'Get the currently logged in `User`, or `null` if the user is a guest'

    def resolve
      current_user
    end
  end
end
