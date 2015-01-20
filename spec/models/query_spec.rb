require 'rails_helper'

RSpec.describe Query, :type => :model do
  describe 'validations' do

  	it { should validate_presence_of :name }
  	it { should validate_presence_of :locality }
  	it { should validate_presence_of :skill }

  	it { should allow_value('Southampton, United Kingdom').for(:locality) }
  	it { should_not allow_value('123XYZ').for(:locality) }

  	it { should allow_value('Ruby on Rails').for(:skill) }
  	it { should_not allow_value('Ruby_on_Rails').for(:skill) }
  	it { should_not allow_value('Ruby123').for(:skill) }

  end

  it 'defaults archived to false' do

  	expect(Query.new).to_not be_archived
  	
  end
end