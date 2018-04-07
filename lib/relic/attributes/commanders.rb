# frozen_string_literal: true
module Relic
  module Attributes
    class Commanders < Relic::Attributes::Collection
      class << self
        protected

        def permitted_attributes
          %i[
            server_id
            pbgid
            name
            description
            icon
            icon_secondary
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
          'commander'
        end
      end
    end
  end
end
