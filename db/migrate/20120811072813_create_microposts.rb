class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id
      #t.integer :msisdn_id

      t.timestamps
    end

    add_index :microposts, :user_id
    #add_index :microposts, :msisdn_id

  end
end
