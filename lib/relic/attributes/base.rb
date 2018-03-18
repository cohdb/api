module Relic
  module Attributes
    class Base
      class << self
        protected

        def attribute_directory_name
          raise 'Implemented in parent'
        end

        def permitted_attributes
          raise 'Implemented in parent'
        end

        def unique_key
          raise 'Implemented in parent'
        end

        def display_key
          raise 'Implemented in parent'
        end

        private

        def config_file_name
          "config/attributes/#{name.demodulize.underscore}.yml"
        end
      end
    end
  end
end
