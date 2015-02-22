require 'rails_helper'

RSpec.describe LeadEducation, :type => :model do

  describe 'validations' do

  	it { should validate_presence_of :name }

  end

  describe 'associations' do

  	it { should belong_to :lead }
  	
  end

end