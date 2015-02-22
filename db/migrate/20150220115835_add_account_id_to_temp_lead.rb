class AddAccountIdToTempLead < ActiveRecord::Migration
  def change
  	add_column :temp_leads, :account_id, :integer, :null => false
  end
end
