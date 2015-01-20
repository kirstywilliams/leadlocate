class Query < ActiveRecord::Base

	belongs_to :account
	has_many :leads
	has_many :temp_leads

	validates :name, presence: true
	validates :locality, presence: true,
						 format: { with: /\A[a-z\-\,\s]+\Z/i, message: 'contains invalid characters' }
	validates :skill, presence: true,
					  format: { with: /\A[a-z\-\.\s]+\Z/i, message: 'contains invalid characters' }


	def is_done

		TempLead.where("query_id = ?", self.id).count == 0
		
	end

end