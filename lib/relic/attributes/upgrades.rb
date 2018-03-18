module Relic
  module Attributes
    class Upgrades < Relic::Attributes::Collection
      class << self
        protected

        def permitted_attributes
          [
            :pbgid,
            :screen_name,
            :icon_name,
            :help_text,
            :extra_text,
          ]
        end

        def unique_key
          :pbgid
        end

        def display_key
          :screen_name
        end

        def attribute_directory_name
          'upgrade'
        end
      end
    end
  end
end
