# -*- encoding : utf-8 -*-

require 'couchdbtools/config'
require 'couchdbtools/error'
require 'couchdbtools/database'
require 'couchdbtools/document'

# Basic module Couchdbtools
# 
# Here all the different CouchDB API areas are beeing created
# 
# Example:
#   Couchdbtools.setup
#   Couchdbtools.database.all_dbs
# @author Andy Wenk andy@nms.de
module Couchdbtools

  # setup is invoking the config and has to be called always before 
  # any interaction with Couchdbtools is started
  def self.setup
    @@config = Couchdbtools::Config.new
  end

  # @return config 
  def self.config
    @@config
  end

  # @return an instance of Database 
  def self.database
    Couchdbtools::Database.new
  end

  # @param db_name 
  # @return an instance of Document
  def self.document db_name = nil
    Couchdbtools::Document.new db_name || @@config.db_name
  end
end
