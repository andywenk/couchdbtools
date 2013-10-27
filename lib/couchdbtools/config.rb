# -*- encoding : utf-8 -*-

require 'yaml'
require 'couchdbtools/request'

module Couchdbtools
  HOMEPAGE = "http://github.andywenk/couchdbtools"

  # Config
  #
  # @author Andy Wenk andy@nms.de
  class Config
    attr_reader :host, :db_name, :port, :protocol, :logfile

    def initialize
      load
    end

    private

    def load
      config_path = File.expand_path('../../../', __FILE__)
      config = symbolize_keys(YAML.load_file("#{config_path}/config.yml"))
      config_for_db(config[:db])
      @logfile = config[:app][:logfile]
    end

    def symbolize_keys(hash)
      hash.inject({}) do |result, (key, value)|
        symbolized_key(result, key, value)
      end
    end

    def symbolized_key(result, key, value)
      new_key = key.is_a?(String) ? key.to_sym : key
      new_value = value.is_a?(Hash) ? symbolize_keys(value) : value
      result[new_key] = new_value
      result
    end

    def config_for_db(db)
      @db_name = db[:name]
      @port = db[:port]
      @protocol = db[:protocol]
      @host = db[:host]
    end
  end

end
