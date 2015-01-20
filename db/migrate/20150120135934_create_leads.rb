class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
    	t.string :first_name, 		null: false
    	t.string :last_name,		null: false
    	t.string :headline
    	t.string :summary
    	t.string :linkedin_url, 	null: false
    	t.string :photo_url
    	t.string :location
    	t.string :country
    	t.string :industry
    	t.integer :query_id
    end

    add_index :leads, :query_id
  end
end
