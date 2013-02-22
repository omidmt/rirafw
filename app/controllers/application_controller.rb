class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper


  before_filter :_reload_libs, :if => :_reload_libs?
  before_filter :validate

  RELOAD_LIBS = Dir[Rails.root + 'lib/**/*.rb'] if Rails.env.development?

  def _reload_libs
    RELOAD_LIBS.each do |lib|
      require_dependency lib
    end
  end

  def _reload_libs?
    defined? RELOAD_LIBS
  end

end
