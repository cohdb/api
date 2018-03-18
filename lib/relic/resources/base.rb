module Relic
  module Resources
    class Base
      class << self
        private

        def config_file_name(language)
          "config/resources/#{language}.yml"
        end
      end
    end
  end
end
