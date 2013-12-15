# -*- encoding : utf-8 -*-

require 'logger'

module Couchdbtools
  module Error
    config = Couchdbtools::Config.new
    $LOG = Logger.new(config.logfile, 'monthly')
    $LOG.datetime_format = config.log_date_time_format
    $LOG.level = config.loglevel

    def self.log_error(name = '', message = '', exception = nil)
      if !exception.nil? && $LOG.debug?
        message = "inspection: #{exception.inspect}\n\n"
        message << "backtrace: #{exception.backtrace}"
        puts message
        $LOG.error("\n#{message}\n")
      else
        message = "in #{name} with message: #{message}"
        puts message
        $LOG.error("#{message}\n\n")
      end
      return
    end

    # DatabaseDoesNotExist
    #
    # @author Andy Wenk andy@nms.de
    class DatabaseDoesNotExist < StandardError
      def initialize
        @message = 'The requested database does not exist.'
        Error.log_error(self, @message)
      end
    end

    # DocumentRevisionRequired
    #
    # @author Andy Wenk andy@nms.de
    class DocumentRevisionRequired < StandardError
      def initialize
        @message = 'Please provide a document _rev.'
        Error.log_error(self, @message)
      end
    end

    # HashAsParamExpected
    #
    # @author Andy Wenk andy@nms.de
    class HashAsParamExpected < StandardError
      def initialize
        @message = 'The params have to be provided as a Hash'
        Error.log_error(self, @message)
      end
    end

    # EmptyParamNotAllowed
    #
    # @author Andy Wenk andy@nms.de
    class EmptyParamNotAllowed < StandardError
      def initialize
        @message = 'The params must not be empty'
        Error.log_error(self, @message)
      end
    end
  end
end


