module LeadHelper

	def lead_photo(lead)

		lead.photo_url.empty? ? "https://static.licdn.com/scds/common/u/images/themes/katy/ghosts/person/ghost_person_200x200_v1.png" : "#{lead.photo_url}"
		
	end
end