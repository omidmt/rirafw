# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Erira::Application.initialize!
Delayed::Worker.destroy_failed_jobs = false
