FactoryGirl.define do
	
  factory :user do

  	name 'Kirsty'
  	sequence(:email) { |n| "email#{n}@digitisedlipstick.com" }
    password 'pw'

  end

end
