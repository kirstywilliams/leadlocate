class RenameColumns < ActiveRecord::Migration
  def change
  	rename_column :lead_groups, :linkedin_url, :link
  	add_column :lead_companies, :start_date, :date
  	add_column :lead_companies, :end_date, :date
  	add_column :lead_companies, :company_type, :string
  end
end
