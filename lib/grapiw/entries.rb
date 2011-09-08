module Grapiw
  class Entries < Array
    include Utilities
    
    attr_accessor :continuation  # Continuation token (don't use)
    attr_reader :session
    attr_reader :url
    
    def self.fetch(session, url, options={})
      results = Grapiw::Utilities.build_call(session, url, :get, options)
      entries = results['items'].map{|a| Entry.new(@session, self, a)}
      new(entries, session, options.merge(:url => url, :continuation => results['continuation']))
    end
    
    def more(options={})
      entries = Grapiw::Entries.fetch(session, url, options.merge(:from => @continuation))
      @continuation = entries.continuation
      entries
    end
    
    def initialize(entries, session, options={})
      super entries
      @continuation = options[:continuation]
      @url          = options[:url]
      @session      = session
    end
    
  end
end