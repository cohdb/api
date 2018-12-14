# frozen_string_literal: true
module Resolvers
  class ListRecords < Base
    class << self
      def [](model_class)
        resolver = Class.new(Base)

        attach_type(resolver, model_class)
        attach_description(resolver, model_class)
        attach_arguments(resolver, model_class)

        define_filtering_strategy(resolver, model_class)
        define_paging_strategy(resolver, model_class)
        define_resolve(resolver, model_class)

        resolver
      end

      protected

      def attach_type(resolver, model_class)
        resolver.type("Types::#{model_class}ListType".constantize, null: false)
      end

      def attach_description(resolver, model_class)
        resolver.description("Receive a list of `#{model_class.name.demodulize}`s")
      end

      def attach_arguments(resolver, model_class)
        resolver.argument(:first, Integer, required: false, default_value: 10, prepare: ->(first, _) { [first, 50].min })
        resolver.argument(:cursor, GraphQL::Types::ID, required: false)

        transform = Graphql::ModelTransformationService.new(model_class, permitted_attributes_for(model_class, :index))
        transform.attach_arguments_to(resolver)
      end

      def define_filtering_strategy(resolver, model_class)
        resolver.define_method(:filtering_strategy) do |params|
          strategy_class = "#{model_class}::ListRecordsFilteringStrategy".safe_constantize
          if strategy_class.nil?
            ListRecordsFilteringStrategy.new(model_class, params)
          else
            strategy_class.new(params)
          end
        end
        resolver.send(:private, :filtering_strategy)
      end

      def define_paging_strategy(resolver, model_class)
        resolver.define_method(:paging_strategy) do |params|
          strategy_class = "#{model_class}::ListRecordsPagingStrategy".safe_constantize
          if strategy_class.nil?
            ListRecordsPagingStrategy.new(params)
          else
            strategy_class.new(params)
          end
        end
        resolver.send(:private, :paging_strategy)
      end

      def define_resolve(resolver, model_class)
        resolver.define_method(:resolve) do |**params|
          authorize(model_class, :index?)
          scope = policy_scope(model_class)
          scope = filtering_strategy(params).apply_to(scope)

          paging_strategy = paging_strategy(params)
          scope = paging_strategy.apply_to(scope)
          {
            records: scope,
            meta: { cursor: paging_strategy.cursor_for(scope) }
          }
        end
      end
    end
  end
end
