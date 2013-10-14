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
module Couchdbtools
  class Server

    attr_reader :request

    def initialize(request)
      @request = request
    end

    # get all existing databases
    def all_dbs
      request.no_check = true
      request.method = :get
      request.uri = '_all_dbs'
      Couchdbtools.execute(request)
    end

    # get one uuid
    def uuids
      request.no_check = true
      request.method = :get
      request.uri = '_uuids'
      Couchdbtools.execute(request)
    end
  end
end
