# -*- encoding : utf-8 -*-

require 'couchdbtools/request'

# Database API
#
# Example:
#   tba
# @author Andy Wenk andy@nms.de
module Couchdbtools::Api
  class Config

    attr_reader :request

    def initialize(request)
      @request = request
    end

  end
end
