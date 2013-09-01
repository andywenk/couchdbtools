# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

module Couchdbtools
  class Database

    def initialize
      @request = Couchdbtools::Request.new
    end

    def all_dbs
      @request.method = :get
      @request.uri = '_all_dbs'
      execute
    end

    def create(db_name)
      @request.method = :put
      @request.uri = db_name
      execute
    end

    def delete(db_name)
      @request.method = :delete
      @request.uri = db_name
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
