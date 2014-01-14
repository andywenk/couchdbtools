# -*- encoding : utf-8 -*-

require 'yaml'
require 'couchdbtools/helper'
require 'couchdbtools/request'

module Couchdbtools
  VERSION = "0.0.3"
  HOMEPAGE = "http://github.andywenk/couchdbtools"

  # Config
  #
  # @author Andy Wenk andy@nms.de
  class Config
    include Couchdbtools::Helper

    attr_reader :host, :db_name, :port, :protocol, :logfile, :loglevel, :log_date_time_format

    def initialize
      load
    end

    private

    def load
      config_for_db
      log_attributes
    end

    def log_attributes
      config_data_app = config_data[:app]
      @logfile = config_data_app[:logfile]
      @loglevel = config_data_app[:loglevel]
      @log_date_time_format = config_data_app[:log_date_time_format]
    end

    def config_for_db
      db = config_data[:db]
      @db_name = db[:name]
      @port = db[:port]
      @protocol = db[:protocol]
      @host = db[:host]
    end

    def config_data
      config_path = File.expand_path('../../../', __FILE__)
      symbolize_keys(YAML.load_file("#{config_path}/config.yml"))
    end
  end
end
