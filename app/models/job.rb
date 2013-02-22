class Job < ActiveRecord::Base

  TARIFF_DISTRIBUTE_QUEUE = 'tariffDQ'
  #TARIFF_ACTIVATE_QUEUE = 'tariffAQ'
  MAIL_DELIVERY_QUEUE = 'mailQ'
  GENERAL_QUEUE = 'generalQ'


  STATUS_ADDED_2_Q = 0
  STATUS_PROCESSING = 1
  STATUS_FINISHED = 2
  STATUS_FAILED = 3
  STATUS_CANCELED = 4
  STATUS_PARTIALLY_SUCCEED = 5

  attr_accessible :logFile, :message, :startTime, :endTime, :taskId, :userId, :name, :category, :status, :schedule, :recurrence

  belongs_to :user, :foreign_key => 'userId'
  #has_one :user

  def self.statusToString( status )
    case status
      when STATUS_ADDED_2_Q
        "Added to queue"
      when STATUS_PROCESSING
        "Running"
      when STATUS_FINISHED
        "Finished"
      when STATUS_FAILED
        "Failed"
      when STATUS_CANCELED
        "Canceled"
      when STATUS_PARTIALLY_SUCCEED
        "Partially Succeed"
      else
        "Unknown Status"
    end
  end

  # Add new job to queue for processing
  # Params Required:
  #                  task : Task instance with perform method
  #                  name : task name
  #                  userId : current user who owns the job
  #        Optionals:
  #                  queue : target queue name for processing (default: '')
  #                  category : the group ot category that job belongs to (default: 'general')
  #                  message : initial message (like 'Added 2 Q') (default: 'Waiting to process')
  #                  logFile : file address for log purposes (completely deprecated and removed)
  #
  def self.enqueue( args )
    task = args[:task] or raise ArgumentError
    name = args[:name] or raise ArgumentError
    userId = args[:userId] or raise ArgumentError
    queue = args[:queue] || GENERAL_QUEUE
    category = args[:category] || 'general'
    message = args[:message] || 'Waiting to process'
    logFile = args[ :logFile] || nil

    job = Job.new( :userId => userId,
                   :logFile => logFile, :status => STATUS_ADDED_2_Q, :name => name,
                   :category => category, :message => message )

    djTask = Delayed::Job.enqueue( task, :queue => queue )
    job.taskId = djTask.id
    job.task_created_at = djTask.created_at

    if job.save
      return job
    else
      return false
    end
  end

end
