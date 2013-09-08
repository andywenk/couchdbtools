# -*- encoding : utf-8 -*-

require 'net/http'
require 'uri'
require 'couchdbtools/config'
require 'multi_json'
require 'rest_client'
require 'json'

module Couchdbtools
  class Request
    attr_accessor :method, :uri, :params

    def initialize
      @config = Couchdbtools::Config.new
    end

    def invoke
      raise Couchdbtools::Error::DatabaseDoesNotExist.new unless check
      @uri = "#{parsed_uri}#{@uri}"
      send(@method)
    end

    def get
      @response = RestClient.get uri, :content_type => :json, :accept => :json
    end

    def post
      @response = RestClient.post @uri, @params.to_json, :content_type => :json, :accept => :json
    end

    def put
    end

    def delete
    end

    def response
      MultiJson.load(@response, :symbolize_keys => true)
    end

    private 

    def check
      begin
        couchdb_running? && database_present?
      rescue RestClient::ResourceNotFound => e
        puts e.message
      end
    end

    def couchdb_running?
      json_response = RestClient.get(parsed_uri)
      response_as_hash = MultiJson.load(json_response, :symbolize_keys => true)
      !response_as_hash[:couchdb].nil?
    end

    def database_present?
      return true unless @config.db_name && !@config.db_name.empty?
      uri = "#{parsed_uri}#{@config.db_name}"
      json_response = RestClient.get(uri)
      response_as_hash = MultiJson.load(json_response, :symbolize_keys => true)
      response_as_hash[:db_name] == @config.db_name
    end

    def parsed_uri
      "#{@config.protocol}://#{@config.host}:#{@config.port}/"
    end
  end
end
