# frozen_string_literal: true
module Resolvers
  class FindRecord < Base
    def self.[](type_name)
      Class.new(Base) do
        @@model_name = type_name.name.demodulize

        type type_name, null: false

        argument :id, ID, required: true

        description "Find a specific `#{@@model_name}` by `id`"

        def resolve(id:)
          @@model_name.constantize.find(id)
        end
      end
    end
  end
end
