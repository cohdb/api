class ApiSchema < GraphQL::Schema
  query Types::Query
  mutation Types::Mutation
end
