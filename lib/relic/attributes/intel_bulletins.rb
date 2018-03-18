module Relic
  module Attributes
    class IntelBulletins < Relic::Attributes::Collection
      class << self
        protected

        def permitted_attributes
          [
            :server_id,
            :pbgid,
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
          'intel_bulletin'
        end
      end
    end
  end
end
