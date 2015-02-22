require 'scraper/search_scraper'

namespace :scraping do

  task leads: :environment do

    begin

      Apartment::Tenant.switch('public')
      leads = TempLead.first(10)

      leads.each do |lead|
        BatchProcess.perform_async(lead.id) unless lead.processed == true
        lead.update_attributes(:processed => true)
      end    
    rescue => e
      Rails.logger.warn("\n\nError occurred while processing temp profiles.\n#{e.message}")
    end

  end

end
