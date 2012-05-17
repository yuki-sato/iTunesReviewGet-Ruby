class ITunesReviews

  require "rexml/document"
  require "open-uri"
  require "time"
  
  require_relative "review"

  
  attr_accessor :reviews
  
  def initialize
    @title=nil
    @updated=nil?
    @reviews = Array.new
  end
  
  def getReviewsFromNew(country, appId)
    
    url = "http://itunes.apple.com/"+ country +"/rss/customerreviews/id="+ appId +"/sortBy=mostRecent/xml"
    
    rssText=""
    open(url) do |f|
       rssText = f.read
    end
    
    if rssText.length==0
      puts "Network error"
    end
    
    @reviews = Array.new
    
    rss = REXML::Document.new(rssText)
    
    @title = rss.elements["feed/title"].text
    @updated = rss.elements["feed/updated"].text
    
    #解析
    rss.elements.each("//entry") do |entry|
      anReview = Review.new
      anReview.id = entry.get_text("id").to_s.to_i
      anReview.title = entry.get_text("title").to_s
      anReview.updated = Time.parse(entry.get_text("updated").to_s)
      anReview.content = entry.get_text("content[@text='type']").to_s
      anReview.rate = entry.get_text("im:rating").to_s.to_i     #REXML::Text->Text->Integer
      anReview.version = entry.get_text("im:version").to_s
      anReview.author = entry.get_text("author/name").to_s
      anReview.country = country
      
      @reviews << anReview
    end
  end
  
end