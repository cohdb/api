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

        def parse_attributes
          @collection = {}

          parse_directory("/Users/ryantaylor/Downloads/attributes/instances/#{attribute_directory_name}")

          File.open(config_file_name, 'w') do |f|
            f.write(@collection.to_yaml)
          end
        end

        private

        def attributes
          @attributes ||= YAML.load(File.read(config_file_name))
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
end
