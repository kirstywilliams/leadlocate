class Query < ActiveRecord::Base

	validates :name, presence: true
	validates :locality, presence: true,
						 format: { with: /\A[a-z\-\,\s]+\Z/i, message: 'contains invalid characters' }
	validates :skill, presence: true,
					  format: { with: /\A[a-z\-\.\s]+\Z/i, message: 'contains invalid characters' }

end