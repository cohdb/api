module Attributes
  class AttributeCollection
    class << self
      def find(key)
        @collection[key]
      end

      def to_localized_string(key, language)
        return 'UNKNOWN' unless find(key)
        Resources::RelicResources.resource_text(find(key)[display_key], language) || 'UNKNOWN'
      end

      def parse_attributes
        collection = {}

        parse_directory("/Users/ryantaylor/Downloads/assets/data/attributes/instances/#{attribute_directory_name}")
        
        File.open(config_file_name, 'w') do |f|
          f.write(@collection.to_yaml)
        end
      end

      def load_from_config
        @collection = YAML.load(File.read(config_file_name))
      end

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

      def attributes
        @attributes ||= {}
      end

      def config_file_name
        "config/attributes/#{name.demodulize.underscore}.yml"
      end

      def parse_directory(directory)
        Dir.foreach(directory) do |item|
          next if item == '.' || item == '..'
          path = "#{directory}/#{item}"
          parse_directory(path) if File.directory?(path)
          parse_file(path) if File.file?(path)
        end
      end

      def parse_file(file)
        begin
          xml = File.open(file) do |f|
            Nokogiri::XML(f)
          end
        rescue
          return
        end

        vals = {}

        permitted_attributes.each { |attr| vals[attr] = xml.css("[name='#{attr}']").first&.attribute('value')&.value }

        @collection[vals[unique_key]] = vals
      end
    end
  end
end
