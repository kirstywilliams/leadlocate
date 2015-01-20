class LeadGroup < ActiveRecord::Base

  belongs_to :lead

  validates :name, presence: true
  validates :linkedin_url, presence: true

end