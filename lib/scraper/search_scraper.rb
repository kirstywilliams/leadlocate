require 'rubygems'
require 'mechanize'
require_relative 'yahoo_search_scraper'

class SearchScraper
  attr_reader :scraper
  
  def initialize(search_engine, query)

    case search_engine
    when /yahoo/ then @scraper = YahooProfileScraper.new(query)
    end

  end
  
  def to_s

    "#{@scraper}"
    
  end
end