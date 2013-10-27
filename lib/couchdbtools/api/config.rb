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

  end
end
