# -*- encoding : utf-8 -*-

require 'rest-client'
require 'net/http'
require 'multi_json'
require 'couchdbtools/config'

module Couchdbtools
  class Request
    attr_accessor :method, :uri, :params, :no_check
    attr_reader :request, :config

    def initialize(config)
      @config = config
    end

    def invoke
      unless no_check
        raise Couchdbtools::Error::DatabaseDoesNotExist.new unless check
      end
      @uri = "#{base_uri}#{@uri}"
      send(@method)
    end

    def post
      @request = RestClient.post uri, params.to_json, content_type: :json, accept: :json
    end

    def get
      @request = RestClient.get request_uri, :content_type => :json, :accept => :json
    end

    def head
      @request = RestClient.head(request_uri).headers
    end

    def put
      @request = RestClient.put request_uri, params_without_id, :content_type => :json, :accept => :json
    end

    def delete
      @request = RestClient.delete uri, :content_type => :json, :accept => :json
    end

    def response
      MultiJson.load(request, :symbolize_keys => true)
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
      return true unless config.db_name && !config.db_name.empty?
      uri = "#{base_uri}#{@config.db_name}"
      json_response = RestClient.get(uri)
      response_as_hash = MultiJson.load(json_response, :symbolize_keys => true)
      response_as_hash[:db_name] == config.db_name
    end

    def request_uri
      return uri unless params && params[:id]
      "#{@uri}/#{@params[:id]}"
    end

    def base_uri
      "#{@config.protocol}://#{@config.host}:#{@config.port}/"
    end

    def params_without_id
      return {} unless params
      params.dup.select { |k| k != :id }.to_json
    end
  end
end
