require 'yaml'

module Couchdbtools
  HOMEPAGE = "http://github.andywenk/couchdbtools"
  
  module Config
    attr_reader :dbname, :port

    class << self
      def load
        config_path = File.expand_path('../../../', __FILE__)
        config = symbolize_keys(YAML.load_file("#{config_path}/config.yml"))
        @dbname = config[:db][:name]
        @port = config[:db][:port]
      end

      def symbolize_keys(hash)
        hash.inject({}) do |result, (key, value)| 
          new_key = key.is_a?(String) ? key.to_sym : key
          new_value = value.is_a?(Hash) ? symbolize_keys(value) : value
          result[new_key] = new_value
          result
        end
      end
    end
  end
  
end
