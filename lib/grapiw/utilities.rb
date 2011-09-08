module Grapiw
  module Utilities
    extend self
    
    AUTH_URL = "https://www.google.com/accounts/ClientLogin"
    API_URL  = "http://www.google.com/reader/api/0/"
    
    def build_call(session, url, method, options={})
      options = convert_options(options).merge!('output' => 'json')
      url = API_URL + url
      JSON.parse(RestClient.send(method, url, :params => options, :Authorization => "GoogleLogin auth=#{session.auth}"))
    end
    
  protected
    
    def convert_options(options={})
      params = Hash.new
      params[:n] = options[:limit] if options[:limit]
      params[:c] = options[:from]  if options[:from]
      params
    end
    
  end
end