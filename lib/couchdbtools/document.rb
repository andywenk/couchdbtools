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
  #   documents.doc
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

    attr_accessor :db_name, :id

    def initialize(db_name)
      @request = Couchdbtools::Request.new
      @db_name = db_name
    end

    def all_docs
      @request.method = :get
      @request.uri = "#{@db_name}/_all_docs"
      execute
    end

    def doc
      @request.method = :get
      @request.uri = "#{@db_name}/#{@id}"
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
