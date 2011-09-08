module Grapiw
  class Feed
    include Utilities
    
    attr_reader :url
    attr_reader :title
    attr_reader :sortid
    attr_reader :id
    attr_reader :session
    attr_reader :options
    
    def initialize(session=Session.new, *args)
      @session  = session
      options   = args.extract_options!
      @title    = options['title']
      @url      = options['id'].gsub("feed/","")
      @sortid   = options['sortid']
      @id       = options['id']
      @tags_    = options['categories']
    end
    
    def entries(options={})
      @entries ||= Entries.fetch(@session, "stream/contents/#{id}", options)
    end
    
    
    def inspect
      "#<#{self.class.name} \"#{title}\" (#{url})>"
    end
    
    def expire!
      @entries = nil
    end
    
  end
end