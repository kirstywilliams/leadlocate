class LeadLanguage < ActiveRecord::Base

  belongs_to :lead

  validates :language, presence: true
  validates :proficiency, presence: true

end