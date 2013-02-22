class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :ip
      t.integer :port
      t.integer :port2
      t.integer :port3
      t.integer :port4
      t.string :user
      t.string :pass
      t.string :user2
      t.string :pass2
      t.string :user3
      t.string :pass3
      t.string :user4
      t.string :pass4
      t.string :klass
      t.string :serverModel
      t.boolean :active

      t.timestamps
    end

    add_index :nodes, [ :name, :ip, :klass ], :name => "index_nodes_on_name_and_ip_and_klass", :unique => true

  end
end
