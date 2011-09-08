require("grapiw/configuration")

module Grapiw
  extend Configuration
  
  def self.configure
    yield self if block_given?
  end
  
  def self.auth(options={})
    options[:email]      = options[:email]      ||= Grapiw.email
    options[:password]   = options[:password]   ||= Grapiw.password
    
    client = Grapiw::Client.new(options)
    client if client.logged_in?
  end
  
end
