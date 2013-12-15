# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

module Couchdbtools::Api
  # Config
  #
  # Example:
  #   tba
  #
  # @author Andy Wenk andy@nms.de
  class Config

    attr_reader :request

    def initialize(request)
      @request = request
    end

    def config(params_hash)
      raise_error_unless_params_is_a_hash(params_hash)
      request.no_check = true
      request.method = :put
      request.uri = "_config#{querystring(params_hash)}"
      Couchdbtools.execute(request)
    end

  end
end
