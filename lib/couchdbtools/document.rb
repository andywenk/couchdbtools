# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

module Couchdbtools
  # Document
  # 
  # Wrapping the CouchDB Document API
  # 
  # Example:
  #   Couchdbtools.setup
  #   documents = Couchdbtools.document
  #   documents.id = 'b0123'
  #   documents.get
  #
  #   {:_id=>"b0123",
  #    :_rev=>"1-f40befcf3da87b7f8cadea607756b95d",
  #    :typ=>"Einnahme",
  #    :mwst=>0.07,
  #    :datum=>"2011-04-02",
  #    :betrag=>24.9,
  #    :beschreibung=>"Büromaterial"}
  # @author Andy Wenk andy@nms.de
  class Document

    attr_accessor :response, :db_name, :id, :params

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

    # receive one specific document
    # maps to GET /db_name/doc_id
    def get
      @request.method = :get
      @request.uri = "#{@db_name}/#{@id}"
      execute
    end

    # create one new document
    # maps to POST /db_name -d json_string
    def post(params = nil)
      params ||= @params
      @request.method = :post
      @request.uri = "#{@db_name}"
      @request.params = params
      execute
    end

    private

    # invoke the request and return the response result
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
