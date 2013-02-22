class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :role_id
      t.integer :right_id

      t.timestamps
    end
    add_index :permissions, [:role_id, :right_id], :unique => true
  end
end
