require 'rails_helper'

describe 'query creation' do
	let!(:account) { create(:account_with_schema) }
	let(:user) { account.owner }

	before do

		set_subdomain(account.subdomain)
		sign_user_in(user)

	end

	it 'allows user to create query' do

		visit root_path
		click_link "New Query"

		fill_in "Name", with: "Test Query"
		fill_in "Locality", with: "United Kingdom"
		fill_in "Skill", with: "Ruby on Rails"
		expect(page).to_not have_text "Archived"
		click_button "Create Query"

		expect(page).to have_text "Query created!"
		expect(page).to have_text "Test Query"

	end

	it 'displays query validations' do

		visit root_path
		click_link "New Query"

		click_button "Create Query"
		expect(page).to have_text "can't be blank"

	end

	it 'allows user to edit query' do

		query = create(:query)

		visit root_path
		click_edit_query_button query.name

		fill_in "Name", with: "Test Query (B)"
		check "Archived"
		click_button "Update Query"

		expect(page).to have_text "Query updated!"
		expect(page).to have_text "Test Query (B)"

	end

	def click_edit_query_button(query_name)

		within find("h3", text: query_name) do
			page.first("a").click
		end
		
	end

end