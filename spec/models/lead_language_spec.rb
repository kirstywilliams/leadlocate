require 'rails_helper'

RSpec.describe LeadLanguage, :type => :model do

  describe 'validations' do

  	it { should validate_presence_of :language }
  	it { should validate_presence_of :proficiency }

  end

  describe 'associations' do

  	it { should belong_to :lead }
  	
  end

end