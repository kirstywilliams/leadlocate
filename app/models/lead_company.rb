class LeadCompany < ActiveRecord::Base

  belongs_to :lead

  validates :title, presence: true

  scope :is_past, lambda { where("end_date <= ?", Date.today) }
  scope :is_current, lambda { where("end_date = ?", nil) }

end