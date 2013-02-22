class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.string :user
      t.datetime :datetime
      t.text :message
      t.string :origin

      t.timestamps
    end
  end
end
