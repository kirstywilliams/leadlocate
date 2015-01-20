require 'rails_helper'

RSpec.describe LeadGroup, :type => :model do

  describe 'validations' do

  	it { should validate_presence_of :name }
  	it { should validate_presence_of :linkedin_url }

  end

  describe 'associations' do

  	it { should belong_to :lead }
  	
  end

end