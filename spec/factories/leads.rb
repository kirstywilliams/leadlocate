FactoryGirl.define do

	factory :lead do

		association :query, factory: :query, strategy: :build

		first_name "Kirsty"
    	last_name "Williams"
    	headline "Software Engineer"
    	summary "Test Summary"
    	linkedin_url "http://uk.linkedin.com/in/williamskirsty"
    	photo_url "https://media.licdn.com/mpr/mpr/shrink_200_200/p/1/000/2b2/372/1c2e1fe.jpg"
    	location "London"
    	country "United Kingdom"
    	industry "Computer Software"
    	
	end
	
end