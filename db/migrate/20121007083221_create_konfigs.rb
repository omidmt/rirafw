class CreateKonfigs < ActiveRecord::Migration
  def change
    create_table :konfigs do |t|
      t.string :key
      t.string :value
      t.string :owner

      t.timestamps
    end

    add_index :konfigs, [:key, :value, :owner], :unique => true
  end
end
