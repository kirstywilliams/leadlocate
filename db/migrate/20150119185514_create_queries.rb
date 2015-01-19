class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
    	t.string :name,						 null: false
    	t.string :locality,					 null: false
    	t.string :skill, 					 null: false
    	t.boolean :archived, default: false, null: false
    end
  end
end
