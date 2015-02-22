class TempLead < ActiveRecord::Base
	
	belongs_to :account

	validates_presence_of(:url, :account_id)

end