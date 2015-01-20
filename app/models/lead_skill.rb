class LeadSkill < ActiveRecord::Base

  belongs_to :lead

  validates :skill, presence: true

end