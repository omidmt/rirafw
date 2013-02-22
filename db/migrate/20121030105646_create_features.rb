class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.string :description
      t.string :code
      t.integer :stat
      t.string :hsh
      t.string :expiry
      t.integer :max_user

      t.timestamps
    end
    add_index :features, :code, :unique => true
  end
end
