class AddTimestampsToLeadCompany < ActiveRecord::Migration
  def change
    add_column :lead_companies, :created_on, :date
    add_column :lead_companies, :updated_on, :date
  end
end
