# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

# Database module
# 
# Database API
# 
# Example:
#   Couchdbtools.setup
#   Couchdbtools.database.create('moonbeans')
#   {:ok=>true}
# @author Andy Wenk andy@nms.de
module Couchdbtools
  class Database

    def initialize
      @request = Couchdbtools::Request.new
    end

    # get all existing databases
    def all_dbs
      @request.method = :get
      @request.uri = '_all_dbs'
      execute
    end

    # create a new database
    def create(db_name)
      @request.method = :put
      @request.uri = db_name
      execute
    end

    # delete an existing database
    def delete(db_name)
      @request.method = :delete
      @request.uri = db_name
      execute
    end

    # get one uuid
    def uuids
      @request.method = :get
      @request.uri = '_uuids'
      execute
    end

    # get all docs 
    def all_docs(db_name)
      @request.method = :get
      @request.uri = "#{db_name}/_all_docs"
      execute
    end

    private

    def execute
      begin
        @request.invoke
        @request.response
      rescue Exception => e
        puts e.message
      end
    end
  end

end
