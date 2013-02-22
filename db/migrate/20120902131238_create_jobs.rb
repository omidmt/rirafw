class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :taskId
      t.datetime :task_created_at    # It is added to fix the mysql/innodb behavior on resetting auto-incremental column
                                     # of delayed_job table
                                     # The issue is delayed_job is deleting records after done, when mysql is resetting
                                     # it checks the table for last id to continue from it, but in this case it reset to 0
                                     # When task is running it uses DJ id to find and update jobs record, but it is duplicate
                                     # and the fist one (old one) is updated ( )@job = Job.where( :taskId => @id ) ).
                                     # To fix will use created_at of DJ task in Jobs ( @job = Job.where( :taskId => @id, :task_created_at => job.created_at ).first ).
      t.integer :userId
      t.string  :name
      t.string  :category
      t.integer :status
      t.datetime :schedule
      t.integer :recurrence
      t.text :message
      t.string :logFile
      t.datetime :startTime
      t.datetime :endTime

      t.timestamps
    end

    add_index :jobs, [ :taskId, :task_created_at ], :unique => true

  end
end

