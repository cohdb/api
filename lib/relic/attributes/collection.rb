module Relic
  module Attributes
    class Collection < Relic::Attributes::Base
      class << self
        def find(key)
          attributes[key.to_s]
        end

        def to_localized_string(key, language)
          return 'UNKNOWN' unless find(key)
          Relic::Resources::Collection.resource_text(find(key)[display_key], language) || 'UNKNOWN'
        end

        private

        def attributes
          @attributes ||= YAML.load(File.read(config_file_name))
        end
      end
    end
  end
end
