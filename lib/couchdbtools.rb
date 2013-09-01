require 'couchdbtools/config'

module Couchdbtools
  attr_reader :config
  def self.setup
    @config = Couchdbtools::Config.load
  end
end
