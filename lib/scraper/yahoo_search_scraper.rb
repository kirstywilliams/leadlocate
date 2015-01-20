require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'

class YahooSearchScraper
  attr_accessor :engine, :query, :source_url, :url_extension, :search_results, :total_results
  
  USER_AGENTS = ['Windows IE 6', 'Windows IE 7', 'Windows Mozilla', 'Mac Safari', 'Mac FireFox', 'Mac Mozilla', 'Linux Mozilla', 'Linux Firefox', 'Linux Konqueror']

  def initialize(query)
    @engine = 'yahoo'
    @query = query
    @locality = URI::encode(@query.locality)
    @skill = URI::encode(@query.skill.strip)
    @class_value = 'div.res'
    @link_value = 'a.yschttl'
    @source_url = "http://uk.search.yahoo.com/search?p=%22#{@locality}%22+%22#{@skill}%22+-%E2%80%9Cmore+professionals+named%E2%80%9D+%28site%3Alinkedin.com%2Fin+OR+site%3Alinkedin.com%2Fpub+AND+-site%3Alinkedin.com%2Fpub%2Fdir+AND+-site%3Alinkedin.com%2Fin%2Fdir%29"
    
    @url_extension = "&xargs=0&b="
    @search_results = []
    @total_results = 0
  end
  
  def get_results
    run = true
    count = 11
    
    while run
      if(@total_results == 0)
        doc = Nokogiri::HTML(open("#{@source_url}", "User-Agent" => USER_AGENTS.sample))
      else
        doc = Nokogiri::HTML(open("#{@source_url}#{@url_extension}#{count}", "User-Agent" => USER_AGENTS.sample))
        count += 10
      end
      
      ## Currently yahoo search results max out at 1000
      if doc.search('div.msg.zrp').first or (doc.search('div.res').count < 5 or count > 1011)
        run = false
      else
        # Filter results for rubbish data. Needs refactoring out, ok for testing.
        process_results(doc)
      end
    end

    # Only process each lead profile once. Ignore duplicates.
    unique_results = @search_results.uniq {|r| r[:url]}
    duplicate_results = @search_results.reject{|x| unique_results.include? x[:link]}

    unique_results.each do |lead|
      temp = TempLead.create(url: lead[:url], query_id: @query[:id], processed: false)
      Query.find(@query[:id]).temp_leads << temp
    end
  end      
  
  def process_results(doc)
    doc.search(@class_value).each do |person|
      profile_url = person.search(@link_value).first['href'].gsub(/(http\:\/\/|https\:\/\/)[a-z]+(\.)/i, "")

      correct_pattern = /(linkedin.com)/i
      bad_patterns = [/(\/dir)/i, /(\/pub)/i, /(\/company)/i, /(\/companies)/i, 
        /(linkedin.com\/answers)/i, /(linkedin.com\/static)/i, 
        /(linkedin.com\/about)/i, /(linkedin.com\/settings)/i,
        /(linkedin.com\/shareArticle)/i, /(\/recommendations)/i,
        /(\/connections)/i, /(linkedin.com\/search)/i, /(\/group)/i, 
        /(\s\-\s)[a-zâñéÖ\s]+/i, /[a-zâñéÖ\s]+/i, /(\s\|\s)/i, 
        /(profiles)/i, /(linkedin.com\/job)/i, /(linkedin.com\/jobs2)/i]
      
      re = Regexp.union(bad_patterns)
      partition_pattern = /(\s\-\s)[a-zâñéÖ\s]+/i
      
      unless ((profile_url =~ correct_pattern) and (profile_url !~ re))
        partition = person.search(@link_value).first.text.strip.partition(partition_pattern)
        
        @search_results << {url: profile_url}
        @total_results += 1
      end
    end
  end
end
        