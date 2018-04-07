# frozen_string_literal: true
module Relic
  module Resources
    class Collection < Relic::Resources::Base
      class << self
        def resource_text(resource_id, language)
          resources_for(language)[resource_id]
        end

        private

        def resources_for(language)
          @collection ||= {}
          @collection[language] ||= YAML.safe_load(File.read(config_file_name(language)), [Symbol])
        end
      end
    end
  end
end
