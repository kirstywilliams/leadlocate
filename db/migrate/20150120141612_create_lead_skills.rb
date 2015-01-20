class CreateLeadSkills < ActiveRecord::Migration
  def change
    create_table :lead_skills do |t|
    	t.string :skill, 	null: false
    	t.integer :lead_id
    end

    add_index :lead_skills, :lead_id
  end
end
