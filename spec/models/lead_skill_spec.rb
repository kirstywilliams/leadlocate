require 'rails_helper'

RSpec.describe LeadSkill, :type => :model do

  describe 'validations' do

  	it { should validate_presence_of :skill }

  end

  describe 'associations' do

  	it { should belong_to :lead }
  	
  end

end