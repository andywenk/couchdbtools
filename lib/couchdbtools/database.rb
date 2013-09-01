# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

module Couchdbtools
  class Database
    attr_accessor :path

    def initialize(options_hash)
      initialize_from_hash(options_hash)
      @request = Couchdbtools::Request.new
    end

    def all_dbs
      @request.method = :get
      @request.uri = '/_all_dbs'
      @request.invoke
      @request.response
    end

    private

    def initialize_from_hash(options_hash)
      options_hash.each_pair do | k, v |
        send("#{k}=", v)
      end
    end
  end

end
