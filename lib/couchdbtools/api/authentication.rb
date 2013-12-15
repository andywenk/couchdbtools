# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

module Couchdbtools::Api
  # Server
  #
  # Example:
  #   tba
  #
  # @author Andy Wenk andy@nms.de

  class Authentication

    attr_reader :request

    def initialize(request)
      @request = request
    end

    # initialize a new session with basic authentication
    # http://docs.couchdb.org/en/latest/api/server/authn.html#post--_session
    def initialize_session(params_hash)
      raise_error_unless_params_is_a_hash(params_hash)
      raise_error_if_params_are_empty(params_hash)
      request.no_check = true
      request.method = :post
      request.uri = '_session'
      Couchdbtools.execute(request)
    end

    # retrieve information about the authenticated user
    # http://docs.couchdb.org/en/latest/api/server/authn.html#get--_session
    def retrieve_session
      request.no_check = true
      request.method = :get
      request.uri = '_session'
      Couchdbtools.execute(request)
    end

    # delete the actual session
    # http://docs.couchdb.org/en/latest/api/server/authn.html#delete--_session
    def delete_session
      request.no_check = true
      request.method = :get
      request.uri = '_session'
      Couchdbtools.execute(request)
    end

  end
end
