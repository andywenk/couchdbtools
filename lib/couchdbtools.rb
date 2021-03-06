# -*- encoding : utf-8 -*-

require 'couchdbtools/helper'
require 'couchdbtools/config'
require 'couchdbtools/error'
require 'couchdbtools/api/server'
require 'couchdbtools/api/database'
require 'couchdbtools/api/document'

# Basic module Couchdbtools
#
# Here all the different CouchDB API areas are beeing created
#
# Example:
#   Couchdbtools.setup
#   Couchdbtools.database.all_dbs
#
# @author Andy Wenk andy@nms.de
module Couchdbtools

  attr_reader :config, :request

  # setup is invoking the config and has to be called always before
  # any interaction with Couchdbtools is started
  def self.setup
    @config = Couchdbtools::Config.new
    @request = Couchdbtools::Request.new(@config)
  end

  # @return config
  def self.config
    @config
  end

  # @return an instance of Server
  def self.server
    Couchdbtools::Api::Server.new(@request)
  end

  # @return an instance of Database
  def self.database
    Couchdbtools::Api::Database.new(@request)
  end

  # @param db_name
  # @return an instance of Document
  def self.document db_name = nil
    db_name ||= @config.db_name
    Couchdbtools::Api::Document.new db_name: db_name, request: @request
  end

  # fire the request against CouchDB
  #
  # @param request
  def self.execute(request)
    begin
      request.invoke
      request.response
    rescue Exception => exception
      exception.inspect
    end
  end
end
