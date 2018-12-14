# frozen_string_literal: true
class ApiSchema < GraphQL::Schema
  query Types::QueryType
  mutation Types::MutationType
end
