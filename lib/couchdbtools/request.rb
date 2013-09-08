# -*- encoding : utf-8 -*-

require 'net/http'
require 'uri'
require 'couchdbtools/config'
require 'multi_json'
require 'rest_client'

module Couchdbtools
  class Request
    attr_accessor :method, :uri, :params

    def initialize
      @config = Couchdbtools::Config.new
    end

    def invoke
      raise Couchdbtools::Error::DatabaseDoesNotExist.new unless check
      @uri = "#{base_uri}#{@uri}"
      send(@method)
    end

    def get
      @response = RestClient.get request_uri, :accept => :json
    end

    def post
      @response = RestClient.post @uri, @params.to_json, :content_type => :json, :accept => :json
    end

    def put
      @response = RestClient.put request_uri, params_without_id.to_json, :content_type => :json, :accept => :son
    end

    def delete
      @response = RestClient.delete @uri, :content_type => :json, :accept => :json
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
      json_response = RestClient.get(base_uri)
      response_as_hash = MultiJson.load(json_response, :symbolize_keys => true)
      !response_as_hash[:couchdb].nil?
    end

    def database_present?
      return true unless @config.db_name && !@config.db_name.empty?
      uri = "#{base_uri}#{@config.db_name}"
      json_response = RestClient.get(uri)
      response_as_hash = MultiJson.load(json_response, :symbolize_keys => true)
      response_as_hash[:db_name] == @config.db_name
    end

    def request_uri
      return @uri unless @params && @params[:id]
      "#{@uri}/#{@params[:id]}"
    end

    def base_uri
      "#{@config.protocol}://#{@config.host}:#{@config.port}/"
    end

    def params_without_id
      return {} unless @params
      @params.dup.select { |k| k != :id }
    end
  end
end
