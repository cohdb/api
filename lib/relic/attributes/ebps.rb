# frozen_string_literal: true
module Relic
  module Attributes
    class Ebps < Relic::Attributes::Collection
      class << self
        protected

        def permitted_attributes
          %i[
            pbgid
            screen_name
            icon_name
            help_text
            extra_text
          ]
        end

        def unique_key
          :pbgid
        end

        def display_key
          :screen_name
        end

        def attribute_directory_name
          'ebps/races'
        end
      end
    end
  end
end
