class Backend::SecureController < ApplicationController

  before_filter :authenticate #, :only => [:edit, :update]
  before_filter :authorize

end
