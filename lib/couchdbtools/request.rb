# -*- encoding : utf-8 -*-

require 'rest-client'
require 'net/http'
require 'multi_json'
require 'couchdbtools/config'

module Couchdbtools
  # request
  #
  # @author Andy Wenk andy@nms.de
  class Request
    attr_accessor :method, :uri, :params, :check
    attr_reader :response, :config

    def initialize(config)
      @config = config
    end

    def initialize_from_hash(hash)
      hash.each_pair do |method, param|
        send("#{method}=", param)
      end
    end

    def invoke
      raise Couchdbtools::Error::DatabaseDoesNotExist.new unless database_check
      @uri = "#{base_uri}#{@uri}"
      send(@method)
    end

    def post
      @response = RestClient.post uri, params.to_json, content_type: :json, accept: :json
    end

    def get
      @response = RestClient.get request_uri, content_type: :json, accept: :json
    end

    def head
      @response = RestClient.head(request_uri).headers
    end

    def put
      @response = RestClient.put request_uri, params_without_id, content_type: :json, accept: :json
    end

    def delete
      @response = RestClient.delete uri, content_type: :json, accept: :json
    end

    def response
      begin
        unless is_json?(@response)
          return @response
        end
        MultiJson.load(@response.to_s, symbolize_keys: true)
      rescue MultiJson::LoadError => exception
        Couchdbtools::Error.log_error(exception.inspect, exception.message, exception)
      end
    end

    private

    def database_check
      return true unless check
      begin
        couchdb_running? && database_present?
      rescue RestClient::ResourceNotFound => exception
        puts exception.message
      end
    end

    def couchdb_running?
      response_as_hash = MultiJson.load(RestClient.get(base_uri), symbolize_keys: true)
      !response_as_hash[:couchdb].nil?
    end

    def database_present?
      db_name = config.db_name
      return true unless db_name && !db_name.empty?
      uri = "#{base_uri}#{@config.db_name}"
      MultiJson.load(RestClient.get(uri), symbolize_keys: true)[:db_name] == db_name
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
      params.dup.select { |key| key != :id }.to_json
    end

    def is_json?(suspected_json)
      begin
        !!JSON.parse(suspected_json)
      rescue
        false
      end
    end
  end
end
