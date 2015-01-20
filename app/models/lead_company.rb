class LeadCompany < ActiveRecord::Base

  belongs_to :lead

  validates :title, presence: true

end