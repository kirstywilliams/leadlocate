require 'scraper/parser'

class BatchProcess

  include Sidekiq::Worker
  sidekiq_options unique: true
  
  # Place this job type in the top priority queue which will be checked more frequently
  sidekiq_options :queue => :top_priority
  
  def perform(id)

    temp_lead = TempLead.find(id)
    account = Account.find(temp_lead.account_id)

    Apartment::Tenant.switch(account.subdomain)
    query = Query.find(temp_lead.query_id)
    
    begin
      uri = URI.parse("http://#{temp_lead['url']}")
      
      begin

        profile = Parser::Lead.get_profile(uri)

      rescue => e
        Rails.logger.warn("\n#{DateTime.now}\nError occurred parsing profile found at #{uri}.\nWill try again in 12 hours.\n#{e.message}\n#{e.backtrace}")
        BatchProcess.perform_in(12.hours, id)
      end

      person = 
      {
        query_id: query['id'], 
        first_name: profile.first_name, 
        last_name: profile.last_name, 
        headline: profile.title, 
        summary: profile.summary,
        linkedin_url: profile.linkedin_url,
        photo_url: profile.picture,
        location: profile.location, 
        country: profile.country,
        industry: profile.industry 
      }

      new_lead = Lead.new(person)
      new_lead.lead_certifications << LeadCertification.create(profile.certifications) unless profile.certifications.nil?
      new_lead.lead_companies << LeadCompany.create(profile.current_companies) unless profile.current_companies.nil?
      new_lead.lead_companies << LeadCompany.create(profile.past_companies) unless profile.past_companies.nil?
      new_lead.lead_educations << LeadEducation.create(profile.education) unless profile.education.nil?
      new_lead.lead_groups << LeadGroup.create(profile.groups) unless profile.groups.nil?
      new_lead.lead_languages << LeadLanguage.create(profile.languages) unless profile.languages.nil?
      new_lead.lead_skills << LeadSkill.create(profile.skills) unless profile.skills.nil?
      new_lead.lead_websites << LeadWebsite.create(profile.websites) unless profile.websites.nil?

      if new_lead.save!
        Rails.logger.info("\n#{DateTime.now}\nSaving lead from #{temp_lead.url} for query #{query['id']} on #{Apartment::Tenant.current}")
        puts "Saving lead from #{temp_lead.url} for query #{query['id']} on #{Apartment::Tenant.current}"

        query.leads << new_lead
        temp_lead.destroy!
      else
        Rails.logger.warn("\n#{DateTime.now}\nError saving lead from #{temp_lead.url} for query #{query['id']} on #{Apartment::Tenant.current}.\n#{new_lead.errors.full_messages}.")
      end

    rescue => e

      Rails.logger.warn("\n#{DateTime.now}\nError while parsing profile at #{uri}. Will try again in 12 hours.\n#{e.message}")
      BatchProcess.perform_in(12.hours, id)

    end
  end
end