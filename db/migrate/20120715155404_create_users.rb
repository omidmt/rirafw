class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pswd
      t.string :salt
      t.datetime :expiry
      t.datetime :account_expiry
      t.integer :failed, :default => 0
      t.boolean :lock

      t.timestamps
    end

    add_index :users, :email, :unique => true

  end
end
