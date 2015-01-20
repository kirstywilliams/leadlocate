class LeadWebsite < ActiveRecord::Base

  belongs_to :lead

  validates :site, presence: true

end