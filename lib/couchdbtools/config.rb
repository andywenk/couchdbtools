# -*- encoding : utf-8 -*-

require 'yaml'

module Couchdbtools
  HOMEPAGE = "http://github.andywenk/couchdbtools"
  
  class Config
    attr_reader :host, :db_name, :port, :protocol, :logfile

    def initialize
      load
    end

    private

    def load
      config_path = File.expand_path('../../../', __FILE__)
      config = symbolize_keys(YAML.load_file("#{config_path}/config.yml"))
      @db_name = config[:db][:name]
      @port = config[:db][:port]
      @protocol = config[:db][:protocol]
      @host = config[:db][:host]
      @logfile = config[:app][:logfile]
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
