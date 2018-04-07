module Resources
  class RelicResources
    class << self
      def resource_text(resource_id, language)
        resources_for(language)[resource_id]
      end

      def parse_resources(language)
        collection = {}

        File.open('/Users/ryantaylor/Downloads/assets/RelicCoH2.English.ucs', 'rb:UTF-16LE') do |file|
          file.each_line do |line|
            resource_id, resource_text = line.strip.split("\t")
            collection[resource_id] = resource_text
          end
        end

        File.open(config_file_name(language), 'w') do |f|
          f.write(collection.to_yaml)
        end
      end

      private

      def resources_for(language)
        @collection ||= {}
        @collection[language] ||= YAML.load(File.read(config_file_name(language)))
      end

      def config_file_name(language)
        "config/resources/#{language}.yml"
      end
    end
  end
end
