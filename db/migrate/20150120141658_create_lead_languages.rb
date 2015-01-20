class CreateLeadLanguages < ActiveRecord::Migration
  def change
    create_table :lead_languages do |t|
    	t.string :language,			null: false
    	t.string :proficiency,		null: false
    	t.integer :lead_id
    end

    add_index :lead_languages, :lead_id
  end
end
