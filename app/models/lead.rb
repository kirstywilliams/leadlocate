class Lead < ActiveRecord::Base

	before_validation :set_photo
	
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

	def name

		"#{first_name} #{last_name}"
		
	end

=begin
	# replaced w/ scopes in lead_company
	def current_positions
		
		positions = []
		self.lead_companies.each do |position|
			unless position.end_date < Date.today
				positions << position
			end
		end

		positions
	end

	def past_positions

		positions = []
		self.lead_companies.each do |position|
			unless position.end_date.nil?
				positions << position
			end
		end

		positions
		
	end
=end

	private

	def set_photo

		if self.photo_url =~ /(ghost_person)/i
			self.photo_url = ""
		end

	end

end