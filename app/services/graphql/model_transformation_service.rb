# frozen_string_literal: true
module Graphql
  class ModelTransformationService
    def initialize(model_class, attributes = nil)
      @model_class = model_class
      @attributes = attributes&.map(&:to_s)
      @columns_hash = @attributes.nil? ? model_class.columns_hash : model_class.columns_hash.slice(*@attributes)
    end

    def attach_arguments_to(gql_class)
      types_hash.each do |name, type|
        gql_class.argument(name, type, required: false)
      end
    end

    private

    def types_hash
      @types_hash ||= @columns_hash.map do |name, column|
        [name, column_to_type(column)]
      end.to_h
    end

    def column_to_type(column)
      return GraphQL::Types::ID if column.name == 'id' || column.name.slice(-3..-1) == '_id'
      return GraphQL::Types::String if %i[text string].include?(column.type)
      return GraphQL::Types::Int if %i[integer].include?(column.type)
      return GraphQL::Types::ISO8601DateTime if %i[date time datetime].include?(column.type)
      return GraphQL::Types::Float if %i[float decimal].include?(column.type)
      raise ArgumentError "Column has unrecognized type #{column.type}"
    end
  end
end
