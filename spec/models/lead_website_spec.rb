require 'rails_helper'

RSpec.describe LeadWebsite, :type => :model do

  describe 'validations' do

  	it { should validate_presence_of :site }

  end

  describe 'associations' do

  	it { should belong_to :lead }
  	
  end

end