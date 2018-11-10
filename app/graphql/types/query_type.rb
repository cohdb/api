# frozen_string_literal: true
class Types::QueryType < Types::BaseObject
  field :me, resolver: Resolvers::CurrentUser
  field :replay, resolver: Resolvers::FindRecord[Replay]
  field :commands, resolver: Resolvers::ListRecords[Command]
end
