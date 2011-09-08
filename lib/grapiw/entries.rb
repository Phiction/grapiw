module Grapiw
  class Entries < Array
    include Utilities
    
    attr_accessor :continuation  # Continuation token (don't use)
    attr_reader :client
    attr_reader :url
    
    def self.fetch(client, url, options={})
      results = Grapiw::Utilities.build_call(client, url, :get, options)
      entries = results['items'].map{|a| Entry.new(@client, self, a)}
      new(entries, client, options.merge(:url => url, :continuation => results['continuation']))
    end
    
    def more(options={})
      entries = Grapiw::Entries.fetch(client, url, options.merge(:from => @continuation))
      @continuation = entries.continuation
      entries
    end
    
    def initialize(entries, client, options={})
      super entries
      @continuation = options[:continuation]
      @url          = options[:url]
      @client       = client
    end
    
  end
end