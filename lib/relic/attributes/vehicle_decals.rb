module Relic
  module Attributes
    class VehicleDecals < Relic::Attributes::Collection
      class << self
        protected

        def permitted_attributes
          [
            :server_id,
            :pbgid,
            :decal_name,
            :name,
            :description,
            :icon,
            :rarity,
          ]
        end

        def unique_key
          :server_id
        end

        def display_key
          :name
        end

        def attribute_directory_name
          'vehicle_decal'
        end
      end
    end
  end
end
