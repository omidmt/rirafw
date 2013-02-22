class CreateRights < ActiveRecord::Migration
  def change
    create_table :rights do |t|
      t.string :controller
      t.string :action
      t.integer :policy

      t.timestamps
    end
    add_index :rights, [:controller, :action], :unique => true
  end
end
