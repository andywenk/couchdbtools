# -*- encoding : utf-8 -*-

require 'logger'

module Couchdbtools
  module Error
    config = Couchdbtools::Config.new
    $LOG = Logger.new(config.logfile, 'monthly')
    $LOG.level = Logger::ERROR

    def self.log_error(name, message)
      $LOG.error("\033[91m\n[ERROR:] in #{name} with message: #{message}\n\n\033[39m")
    end

    class DatabaseDoesNotExist < StandardError
      def initialize
        @message = 'The requested database does not exist.'
        Error.log_error(self, @message)
      end
    end

    class DocumentRevisionRequired < StandardError
      def initialize
        @message = 'Please provide a document _rev.'
        Error.log_error(self, @message)
      end
    end

    class HashAsParamExpected < StandardError
      def initialize
        @message = 'The params have to be provided as a Hash'
        Error.log_error(self, @message)
      end
    end

    class EmptyParamNotAllowed < StandardError
      def initialize
        @message = 'The params must not be empty'
        Error.log_error(self, @message)
      end
    end
  end
end


