require 'logger'

module UTIL
  LOG_DEBUG = Logger::DEBUG
  LOG_INFO  = Logger::INFO
  LOG_WARN  = Logger::WARN
  LOG_ERROR = Logger::ERROR
  LOG_FATAL = Logger::FATAL

  class Log
    @@logger = Logger.new(STDOUT)
    @@logger.level = LOG_ERROR


    def self.info(msg)
      @@logger.info(msg)
    end

    def self.debug(msg)
      @@logger.debug(msg)
    end

    def self.warn(msg)
      @@logger.warn(msg)
    end

    def self.error(msg)
      @@logger.error(msg)
    end

    def self.fatal(msg)
      @@logger.fatal(msg)
    end

    def self.unknown(msg)
      @@logger.unknown(msg)
    end

    def self.level(level = Logger::ERROR)
      @@logger.level = level
    end
  end
end
