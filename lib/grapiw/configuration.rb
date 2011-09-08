require("logger")
require("json")
require("rest-client")
require("nokogiri")
require("grapiw/version")
require("grapiw/utilities")
require("grapiw/entries")
require("grapiw/session")
require("grapiw/feed")
require("grapiw/entry")

module Grapiw
  module Configuration
    
    attr_accessor(
      :email,
      :password,
      :log
    )
    
    attr_writer(:log)
    def log?
     @log != false
    end
    
    def log(message)
     logger.send(log_level, "\n\n#{message}\n\n") if log?
    end
    
    attr_writer(:logger)
    def logger
      @logger ||= ::Logger.new(STDOUT)
    end
    
    attr_writer(:log_level)
    def log_level
      @log_level ||= :debug
    end
    
  end
  
end