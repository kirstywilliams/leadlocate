require "scraper/search_scraper"
class Query < ActiveRecord::Base

	after_create(:get_leads)
	has_many :leads

	validates :name, presence: true
	validates :locality, presence: true,
						 format: { with: /\A[a-z\-\,\s]+\Z/i, message: 'contains invalid characters' }
	validates :skill, presence: true,
					  format: { with: /\A[a-z\-\.\s]+\Z/i, message: 'contains invalid characters' }
	validates :account_id, presence: true

	scope :not_archived, lambda { where(:archived => false) }

	scope :total_leads, lambda { Lead.where(:account_id => self.id) }

	def is_processed

		Apartment::Tenant.switch('public')
		no_temp_leads = TempLead.where("query_id = ? AND account_id = ?", 
			self.id, Account.find(self.account_id)).count > 0 ? false : true
		self.processed and no_temp_leads

	end

	private

	def get_leads

		QueryProcess.perform_async('yahoo', self.id)

	end

end