class LeadEducation < ActiveRecord::Base

  belongs_to :lead

  validates :name, presence: true

end