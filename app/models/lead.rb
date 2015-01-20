class Lead < ActiveRecord::Base
	
	belongs_to :query
	has_many :lead_certifications, dependent: :destroy
	has_many :lead_companies, dependent: :destroy
	has_many :lead_educations, dependent: :destroy
	has_many :lead_groups, dependent: :destroy
	has_many :lead_languages, dependent: :destroy
	has_many :lead_organisations, dependent: :destroy
	has_many :lead_skills, dependent: :destroy
	has_many :lead_websites, dependent: :destroy

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :linkedin_url, presence: true

end