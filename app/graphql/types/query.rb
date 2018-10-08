# frozen_string_literal: true
class Types::Query < Types::BaseObject
  field :replay, resolver: Resolvers::FindRecord[Replay]
end
