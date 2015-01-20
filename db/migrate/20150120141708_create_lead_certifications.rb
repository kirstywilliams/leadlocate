class CreateLeadCertifications < ActiveRecord::Migration
  def change
    create_table :lead_certifications do |t|
    	t.string :name, 		null: false
    	t.string :authority
    	t.string :license
    	t.string :start_date
    	t.integer :lead_id
    end

    add_index :lead_certifications, :lead_id
  end
end
