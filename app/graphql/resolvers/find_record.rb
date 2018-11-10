# frozen_string_literal: true
module Resolvers
  class FindRecord < Base
    def self.[](model_class)
      resolver = Class.new(Base)
      resolver.type("Types::#{model_class}Type".safe_constantize, null: false)
      resolver.argument(:id, ID, required: true)
      resolver.description("Find a specific `#{model_class.name.demodulize}` by `id`")
      resolver.define_method(:resolve) do |id:|
        record = model_class.find(id)
        authorize(record, :show?)
      end

      resolver
    end
  end
end
