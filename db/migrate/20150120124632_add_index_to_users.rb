class AddIndexToUsers < ActiveRecord::Migration
  def change
  	add_index :users, [:invited_by_id, :invited_by_type]
  end
end
