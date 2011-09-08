module Grapiw
  
  class Client
    include Utilities
    
    attr_reader(:auth)
    
    def initialize(options={})
      email        = options[:email]      ||= Grapiw.email
      password     = options[:password]   ||= Grapiw.password
      
      response = RestClient.post(
        AUTH_URL,
        'service' => 'reader',
        'Email'   => email,
        'Passwd'  => password,
        'source'  => client_name
      )
      
      @auth = response.scan(/Auth=(.*)/).to_s || nil
      
      true
    rescue RestClient::Forbidden
      false
    end
    
    def logged_in?
      !@auth.nil?
    end
    
    def client_name
      "grapiw-#{Grapiw.version}"
    end
    
    def feeds(options={})
      @feeds ||= build_call(self, "subscription/list", :get, options)['subscriptions'].map{|a| Feed.new(self, a)}
    end
    
    def unread_count
      @unread_count = build_call(self, "unread-count", :get, {})['unreadcounts']
      @unread_count = @unread_count.blank? ? 0 : @unread_count.last['count']
      
      #Grapiw.log(@unread_count.inspect)
      #@unread_count
    end
    
    def expire!
      @feeds = nil
      @tags  = nil
    end
    
  end
  
end