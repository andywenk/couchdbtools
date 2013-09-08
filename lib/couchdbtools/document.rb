# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

module Couchdbtools
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

    attr_accessor :response, :db_name, :params

    # initialize the class
    def initialize(db_name)
      @request = Couchdbtools::Request.new
      @db_name = db_name
    end

    # receive all documents from the specified database
    # maps to GET /db_name/_all_docs
    def all_docs
      @request.method = :get
      @request.uri = "#{@db_name}/_all_docs"
      execute
    end

    # get one specific document
    # maps to GET /db_name/doc_id
    def get(params = nil)
      @request.method = :get
      execute(params)
    end

    # create one new document
    # maps to POST /db_name -d json_string
    def post(params = nil)
      @request.method = :post
      execute(params)
    end

    def put(params = nil)
      @request.method = :put
      execute(params)
    end

    private

    # invoke the request and return the response result
    def execute(params = nil)
      begin
        params ||= @params
        @request.uri = "#{@db_name}"
        @request.params = params
        @request.invoke
        @request.response
      rescue Exception => e
        puts e.message
      end
    end
  end
end
