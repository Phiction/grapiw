module Grapiw
  class Entry

    attr_reader :content
    attr_reader :author
    attr_reader :title
    attr_reader :published
    attr_reader :updated
    attr_reader :url
    attr_reader :id
    attr_reader :feed
    attr_reader :session
    attr_reader :entry
    attr_reader :categories
    
    def initialize(session=Session.new, feed=Feed.new, entry={})
      
      content = entry['content'] || entry['summary']
      content = content['content'] if content.is_a?(Hash)
      
      @session    = session
      @feed       = feed
      @author     = entry['author']
      @content    = content
      @title      = entry['title']
      @published  = Time.at(entry['published'])
      @updated    = Time.at(entry['updated'])
      @url        = entry['alternate'].first['href']
      @id         = entry['id']
      @categories = entry['categories']
      @read       = entry['categories'].any?{ |s| s =~ /com\.google\/read$/ }
      @starred    = entry['categories'].any?{ |s| s =~ /com\.google\/starred$/ }
      @entry      = entry
    end
    
    def doc
      @doc ||= Nokogiri.HTML(content)
    end
    
    def summary
      doc = self.doc.dup
      
      # Remove images and empty paragraphs
      doc.xpath('*//img').each { |tag| tag.remove }
      doc.xpath('*//*[normalize-space(.)=""]').each { |tag| tag.remove }
      
      # The first block
      el = doc.xpath('//body/p | //body/div').first || doc.xpath('//body').first
      el and el.text.gsub(/\n/, "").strip
    end
    
    def image_url
      url = raw_image_url and begin
        return nil  if url.include?('feedburner.com') # "Share on Facebook"
        url
      end
    end

    def raw_image_url
      img = doc.xpath('*//img').first and img['src']
    end
    
    def read?
      @read
    end

    def starred?
      @starred
    end
    
    def inspect
      "#<#{self.class.name} \"#{self.title}\" (#{self.url})>"
    end
    
  end
end