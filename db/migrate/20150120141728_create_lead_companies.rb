class CreateLeadCompanies < ActiveRecord::Migration
  def change
    create_table :lead_companies do |t|
    	t.string :company
    	t.string :title,				null: false
    	t.string :company_url
    	t.text :description
    	t.string :linkedin_company_url
    	t.string :url
    	t.string :company_size
    	t.string :website
    	t.string :industry
    	t.string :founded
        t.string :type
    	t.text :address
    	t.text :headquarters
    	t.integer :lead_id
    end

    add_index :lead_companies, :lead_id
  end
end
