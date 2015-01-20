class CreateLeadWebsites < ActiveRecord::Migration
  def change
    create_table :lead_websites do |t|
    	t.string :site, 		null: false
    	t.integer :lead_id
    end

    add_index :lead_websites, :lead_id
  end
end
