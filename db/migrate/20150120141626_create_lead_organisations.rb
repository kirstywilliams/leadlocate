class CreateLeadOrganisations < ActiveRecord::Migration
  def change
    create_table :lead_organisations do |t|
    	t.string :name, 	null: false
    	t.date :start_date
    	t.date :end_date
    	t.integer :lead_id
    end

    add_index :lead_organisations, :lead_id
  end
end
