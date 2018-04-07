# frozen_string_literal: true
module Relic
  module Attributes
    class Faceplates < Relic::Attributes::Collection
      class << self
        protected

        def permitted_attributes
          %i[
            server_id
            pbgid
            name
            icon
            rarity
          ]
        end

        def unique_key
          :server_id
        end

        def display_key
          :name
        end

        def attribute_directory_name
          'faceplate'
        end
      end
    end
  end
end
