# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

module Couchdbtools::Api
  # Server
  #
  # Example:
  #   Couchdbtools.setup
  #   Couchdbtools.server.all_dbs
  #   _replicator
  #   _user
  #
  # @author Andy Wenk andy@nms.de
  class Server
    include Couchdbtools::Helper

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
    def db_updates(params_hash = {})
      begin
        raise_error_unless_params_is_a_hash(params_hash)
        request.no_check = true
        request.method = :get
        request.uri = "_db_updates#{querystring(params_hash)}"
        Couchdbtools.execute(request)
      rescue Exception => exception
        exception.message
      end
    end

    # get the log output
    # http://docs.couchdb.org/en/latest/api/server/common.html#log
    def log(params_hash = {})
      begin
        raise_error_unless_params_is_a_hash(params_hash)
        request.no_check = true
        request.method = :get
        request.uri = "_log#{querystring(params_hash)}"
        Couchdbtools.execute(request)
      rescue Exception => exception
        exception.message
      end
    end

    # replicate databases
    # http://docs.couchdb.org/en/latest/api/server/common.html#replicate
    def replicate(params_hash)
      begin
        Couchdbtools::Helper.raise_error_unless_params_is_a_hash(params_hash)
        Couchdbtools::Helper.raise_error_if_params_are_empty(params_hash)
        request.no_check = true
        request.method = :post
        request.params = params_hash
        request.uri = "_replicate#{querystring(params_hash)}"
        Couchdbtools.execute(request)
      rescue Exception => exception
        exception.message
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
  end
end
