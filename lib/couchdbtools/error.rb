# -*- encoding : utf-8 -*-

require 'logger' 

module Couchdbtools
  module Error
    binding.pry
    $LOG = Logger.new(Couchdbtools::Config.logfile, 'monthly')
    $LOG.level = Logger::ERROR

    def self.log_error(name, message)
      $LOG.error("\033[91m\n[ERROR:] in #{name} with message: #{message}\n\n\033[39m")
    end

    class DatabaseDoesNotExist < StandardError
      def initialize
        Error.log_error(self, 'The requested database does not exist.')
      end
    end
  end
end


