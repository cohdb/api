module Relic
  module Attributes
    class SkinPacks < Relic::Attributes::Collection
      class << self
        protected

        def permitted_attributes
          [
            :server_id,
            :pbgid,
            :skin_name,
            :name,
            :description,
            :icon,
            :icon_secondary,
            :season,
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
          'skin_pack'
        end
      end
    end
  end
end
