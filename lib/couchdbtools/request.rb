# -*- encoding : utf-8 -*-

require 'net/http'
require 'open-uri'
require 'couchdbtools/config'

module Couchdbtools
  class Request
    attr_accessor :method, :uri, :response

    def initialize
    end

    def invoke
      raise Couchdbtools::Error::DatabaseDoesNotExist.new unless check

    end

    def response
    end

    private 

    def check
      
    end

    def parsed_uri

  end
end
