require 'pry'

module Couchdbtools
  def self.setup
    config = Couchdbtools::Config.load
    puts config.inspect
  end
end
