class AddAccountIdToQuery < ActiveRecord::Migration
  def change
  	add_column :queries, :account_id, :integer
  end
end
