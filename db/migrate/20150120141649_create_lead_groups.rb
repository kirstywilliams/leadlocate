class CreateLeadGroups < ActiveRecord::Migration
  def change
    create_table :lead_groups do |t|
    	t.string :name, 		null: false
    	t.string :linkedin_url, null: false
    	t.integer :lead_id
    end

    add_index :lead_groups, :lead_id
  end
end
