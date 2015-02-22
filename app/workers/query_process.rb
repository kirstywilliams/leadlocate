require 'scraper/search_scraper'

class QueryProcess

  include Sidekiq::Worker
  sidekiq_options unique: true
  
  # Place this job type in the top priority queue which will be checked more frequently
  sidekiq_options :queue => :top_priority
  
  def perform(engine, id)
    
    begin
      
      SearchScraper.new(engine, id)
      
    rescue => e

      Rails.logger.warn("\n\nError while parsing query #{id} on #{Apartment::Tenant.current}.\nWill try again in 12 hours.\n#{e.message}")
      QueryProcess.perform_in(12.hours, engine, id)

    end

  end
end