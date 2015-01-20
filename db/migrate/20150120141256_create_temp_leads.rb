class CreateTempLeads < ActiveRecord::Migration
  def change
    create_table :temp_leads do |t|
    	t.string :url,							null: false
    	t.integer :query_id, 					null: false
    	t.boolean :processed, default: false, 	null: false
    end

    add_index :temp_leads, :query_id
    add_index :temp_leads, :processed
  end
end
