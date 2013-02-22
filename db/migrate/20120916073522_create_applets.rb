class CreateApplets < ActiveRecord::Migration
  def change
    create_table :applets do |t|
      t.string :name
      t.string :icon
      t.string :path
      t.string :description

      t.timestamps
    end

    add_index :applets, [:name], :unique => true

  end
end
