# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

# Server API
#
# Example:
#   Couchdbtools.setup
#   Couchdbtools.server.all_dbs
#   _replicator
#   _user
# @author Andy Wenk andy@nms.de
module Couchdbtools::Api
  class Server

    attr_reader :request

    def initialize(request)
      @request = request
    end

    # get the active tasks
    # http://docs.couchdb.org/en/latest/api/server/common.html#active-tasks
    def active_tasks
      request.no_check = true
      request.method = :get
      request.uri = '_active_tasks'
      Couchdbtools.execute(request)
    end

    # get all existing databases
    # http://docs.couchdb.org/en/latest/api/server/common.html#all-dbs
    def all_dbs
      request.no_check = true
      request.method = :get
      request.uri = '_all_dbs'
      Couchdbtools.execute(request)
    end

    # get the database events
    # http://docs.couchdb.org/en/latest/api/server/common.html#db-updates
    # @param feed (string) -> longpoll | continuous | eventsource
    # @param timeout (number)
    # @param heartbeat (boolean)
    def db_updates(params_hash = {})
      begin
        raise Couchdbtools::Error::HashAsParamExpected unless params_hash.is_a?(Hash)
        request.no_check = true
        request.method = :get
        request.uri = "_db_updates#{querystring(params_hash)}"
        Couchdbtools.execute(request)
      rescue Exception => e
        e.message
      end
    end

    # get the log output
    # http://docs.couchdb.org/en/latest/api/server/common.html#log
    # @param bytes (number)
    # @param offset (number)
    def log(params_hash = {})
      begin
        raise Couchdbtools::Error::HashAsParamExpected unless params_hash.is_a?(Hash)
        request.no_check = true
        request.method = :get
        request.uri = "_log#{querystring(params_hash)}"
        Couchdbtools.execute(request)
      rescue Exception => e
        e.message
      end
    end

    # replicate databases
    # http://docs.couchdb.org/en/latest/api/server/common.html#replicate
    # @param cancel (boolean)
    # @param continuous (boolean)
    # @param create_target (boolean)
    # @param doc_ids (array)
    # @param proxy (string)
    # @param source (string)
    # @param target (string)
    def replicate(params_hash)
      begin
        raise Couchdbtools::Error::HashAsParamExpected unless params_hash.is_a?(Hash)
        raise Couchdbtools::Error::EmptyParamNotAllowed if params_hash.empty?
        request.no_check = true
        request.method = :post
        request.params = params_hash
        request.uri = "_replicate#{querystring(params_hash)}"
        Couchdbtools.execute(request)
      rescue Exception => e
        e.message
      end
    end

    # restart CouchDB
    # http://docs.couchdb.org/en/latest/api/server/common.html#restart
    def restart
      request.no_check = true
      request.method = :post
      request.uri = "_restart"
      Couchdbtools.execute(request)
    end

    # get stats
    # http://docs.couchdb.org/en/latest/api/server/common.html#stats
    def stats
      request.no_check = true
      request.method = :get
      request.uri = "_stats"
      Couchdbtools.execute(request)
    end

    # get one uuid
    # http://docs.couchdb.org/en/latest/api/server/common.html#uuids
    def uuids
      request.no_check = true
      request.method = :get
      request.uri = '_uuids'
      Couchdbtools.execute(request)
    end

    def config(params_hash)
      raise Couchdbtools::Error::HashAsParamExpected unless params_hash.is_a?(Hash)
      request.no_check = true
      request.method = :put
      request.uri = "_config#{querystring(params_hash)}"
      Couchdbtools.execute(request)
    end


    private

    # create a querystring
    # @param query_params (hash)
    def querystring(query_params)
      return "" if query_params.empty?
      query = query_params.map do |k,v|
        "#{k}=#{v}"
      end
      "?#{query.join('&')}"
    end
  end
end
