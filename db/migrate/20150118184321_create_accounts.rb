class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :subdomain
      t.integer :owner_id

      t.timestamps null: false
    end

    add_index :accounts, :owner_id
  end
end