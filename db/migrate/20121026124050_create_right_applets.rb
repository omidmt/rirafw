class CreateRightApplets < ActiveRecord::Migration
  def change
    create_table :right_applets do |t|
      t.integer :right_id
      t.integer :applet_id

      t.timestamps
    end
    add_index :right_applets, [:right_id, :applet_id], :unique => true
  end
end
