# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

module Couchdbtools::Api
  # Database
  #
  # Example:
  #   Couchdbtools.setup
  #   Couchdbtools.database.create('moonbeans')
  #   {:ok=>true}
  #
  # @author Andy Wenk andy@nms.de
  class Database

    attr_reader :request

    def initialize(request)
      @request = request
    end

    # create a new database
    def create(db_name)
      request.method = :put
      request.uri = db_name
      Couchdbtools.execute(request)
    end

    # delete an existing database
    def delete(db_name)
      request.method = :delete
      request.uri = db_name
      Couchdbtools.execute(request)
    end

    # get info about a database
    def get(db_name)
      request.method = :get
      request.uri = db_name
      Couchdbtools.execute(request)
    end

    # get all docs
    # http://localhost:5984/_utils/docs/api/database.html#get-db-all-docs
    def all_docs(db_name)
      request.method = :get
      request.uri = "#{db_name}/_all_docs"
      Couchdbtools.execute(request)
    end

    # get all_docs with specific id's
    # http://localhost:5984/_utils/docs/api/database.html#post-db-all-docs
    def all_docs_by_ids(db_name, params)
      request.method = :post
      request.uri = "#{db_name}/_all_docs"
      request.params = params
      Couchdbtools.execute(request)
    end
  end
end
