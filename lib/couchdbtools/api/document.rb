# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

module Couchdbtools::Api
  # Document
  #
  # Wrapping the CouchDB Document API
  #
  # Example:
  #
  #    tba
  #
  # @author Andy Wenk andy@nms.de
  class Document

    attr_accessor :response, :db_name, :params, :request

    # initialize the class
    def initialize(args)
      @request = args[:request]
      @db_name = args[:db_name]
    end

    # create one new document
    # maps to POST /db_name -d json_string
    def post(params = nil)
      request.method = :post
      execute(params)
    end

    # get one specific document
    # maps to GET /db_name/doc_id
    def get(params)
      request.method = :get
      execute(params)
    end

    # get the headers instead of the document
    # maps to HEAD /db_name/doc:id
    def head(params)
      raise Couchdbtools::Error::DocumentRevisionRequired unless params['_rev']
      request.method = :put
      execute(params)
    end

    def put(params = nil)
      request.method = :put
      execute(params)
    end

    def delete
      request.method = :delete
    end

    def copy
      request.method = :copy
    end

    private

    # invoke the request and return the response result
    def execute(params = nil)
      params ||= @params
      request.uri = "#{@db_name}"
      request.params = params
      Couchdbtools.execute(request)
    end
  end
end
