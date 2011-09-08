require("grapiw/configuration")

module Grapiw
  extend Configuration
  
  def self.configure
    yield self if block_given?
  end
  
  def self.auth(options={})
    options[:email]      = options[:email]      ||= Grapiw.email
    options[:password]   = options[:password]   ||= Grapiw.password
    
    session = Grapiw::Session.new(options)
    session if session.logged_in?
  end
  
end
