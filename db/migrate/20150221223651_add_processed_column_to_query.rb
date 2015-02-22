class AddProcessedColumnToQuery < ActiveRecord::Migration
  def change
  	add_column :queries, :processed, :boolean, default: false, 	null: false
  end
end
