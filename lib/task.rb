# require file that required by subclass tasks

include Util

#TARIFF_SAVE_LOG_DIR = APP_LOG_PATH + "tariff/"
#TARIFF_ACTIVATE_LOG_DIR = APP_LOG_PATH + "tariff/"
#TARIFF_DEACTIVATE_LOG_DIR = APP_LOG_PATH + "tariff/"
#TARIFF_DELETE_LOG_DIR = APP_LOG_PATH + "tariff/"

class Task

  #@id
  #@job

  #def initialize( id )
  #  @id = id
  #end

  attr_accessor :log_counter
  attr_accessor :log_last_write

  def enqueue(job)
    #puts "************** Job queued #{job.inspect} **************"
  end

  def before(job)
    #puts "Going to start job process."
    @id = job.id
    #Applog.info "Starting DJ##{@id}"
    @job = Job.where( :taskId => @id, :task_created_at => job.created_at ).first
    @job.startTime = DateTime.now
    @job.status = Job::STATUS_PROCESSING
    @job.save
  end

  def after(job)
    #puts "Job processed so what ?"
    flush
  end

  def success(job)
    #puts "Job processed successfully."
    @job.message += "\nJob process finished."
    @job.status = Job::STATUS_FINISHED
    @job.endTime = DateTime.now
    @job.save
  end

  def error(job, exception)
    #puts "Job processed with error."
    @job.message += "\nJob has faced error [#{exception}]"
    @job.status = Job::STATUS_FAILED
    @job.endTime = DateTime.now
    @job.save
  end

  def failure
    @job.message += "\nJob process failed, will retry."
    @job.status = Job::STATUS_FAILED
    @job.endTime = DateTime.now
    @job.save
  end

  def log( msg )
    if @job
      @job.message += "\n[#{DateTime.now.to_formatted_s(:db)}] Info: #{msg}"
      #Applog.info "Updating message"

      dtNow = DateTime.now.to_i

      if self.log_last_write.nil? or self.log_counter.nil?
        self.log_last_write = dtNow
        self.log_counter = 0
      end

      if self.log_counter > 5 || dtNow > self.log_last_write + 30
        @job.save
        self.log_counter = 0
        self.log_last_write = dtNow
        #Applog.info 'Save log'
      end
    else
      Applog.info "\n[#{DateTime.now.to_formatted_s(:db)}] Info: #{msg}"
    end
  end

  def logError( msg )
    if @job
      @job.message += "\n[#{DateTime.now.to_formatted_s(:db)}] Error: #{msg}"
      @job.save
    end
  end

  def flush
    @job.save
    self.log_counter = 0
    self.log_last_write = 0
    #Applog.info 'flush'
  end

end

class TestTask < Task

  def perform
    begin
      log "Done!"
      raise StandardError
      puts "Finished"
    rescue => err
      puts "***** Error in updating after process message #{err} *****"
      raise StandardError
    end
  end

end
