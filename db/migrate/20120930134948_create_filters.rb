class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :name
      t.string :group
      t.string :pattern

      t.timestamps
    end

    add_index :filters, [:name, :group, :pattern], :unique => true

  end
end
