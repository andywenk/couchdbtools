# -*- encoding : utf-8 -*-

require 'couchdbtools/config'
require 'couchdbtools/error'

module Couchdbtools
  def self.setup
    @@config = Couchdbtools::Config.new
  end

  def self.config
    @@config
  end
end
