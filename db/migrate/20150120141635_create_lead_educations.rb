class CreateLeadEducations < ActiveRecord::Migration
  def change
    create_table :lead_educations do |t|
    	t.string :name
    	t.text :description
    	t.string :period
    	t.integer :lead_id
    end

    add_index :lead_educations, :lead_id
  end
end
