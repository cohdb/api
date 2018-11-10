# frozen_string_literal: true
module Resolvers
  class ListRecords < Base
    class << self
      def [](model_class)
        resolver = Class.new(Base)

        attach_type(resolver, model_class)
        attach_description(resolver, model_class)
        attach_arguments(resolver, model_class)

        define_strategy(resolver, model_class)
        define_resolve(resolver, model_class)

        resolver
      end

      protected

      def attach_type(resolver, model_class)
        resolver.type(["Types::#{model_class}Type".constantize], null: false)
      end

      def attach_description(resolver, model_class)
        resolver.description("Receive a list of `#{model_class.name.demodulize}`s")
      end

      def attach_arguments(resolver, model_class)
        transform = Graphql::ModelTransformationService.new(model_class, permitted_attributes_for(model_class, :index))
        transform.attach_arguments_to(resolver)
      end

      def define_strategy(resolver, model_class)
        resolver.define_method(:strategy) do |params|
          strategy_class = "#{model_class}::ListRecordsStrategy".safe_constantize
          if strategy_class.nil?
            ListRecordsStrategy.new(model_class, params)
          else
            strategy_class.new(params)
          end
        end
        resolver.send(:private, :strategy)
      end

      def define_resolve(resolver, model_class)
        resolver.define_method(:resolve) do |**params|
          authorize(model_class, :index?)
          strategy(params).apply_to(policy_scope(model_class))
        end
      end
    end
  end
end
