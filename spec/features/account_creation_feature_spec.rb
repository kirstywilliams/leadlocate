require 'rails_helper'

describe 'account creation' do
	it 'allows user to create account' do
		visit root_path
		click_link 'Create Account'

		fill_in 'Name', with: 'Kirsty'
		fill_in 'Email', with: 'kirsty@digitisedlipstick.com'
		fill_in 'Password', with: 'pw'
		fill_in 'Password Confirmation', with: 'pw'
		fill_in 'Subdomain', with: 'digitisedlipstick'
		click_button 'Create Account'

		expect(page).to have_content('Signed up successfully')
	end
end