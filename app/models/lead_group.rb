class LeadGroup < ActiveRecord::Base

  belongs_to :lead

  validates :name, presence: true
  validates :link, presence: true

end