class UserSettingsController < Backend::SecureController

  #before_filter :authenticate #, :only => [:edit, :update]
  before_filter :correct_user

  def edit
    @title = "Edit user settings"
    @microposts = @user.microposts.paginate(:page => params[:page])
    store_location
  end

  # Not used now, Session.update_password is in use instead
  def update
    if !params[:user][:password].blank?
      @user = User.find( current_user )
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      Auditlog( self.class.name, @user )
      if @user.save( :validate => true )
        flash.now[ :success ] = "Settings updated"
      end
      @title = "Edit User Settings"
      #redirect_back_or home_path
      render :edit
      #redirect_to root_path
    end

  end

  private

    #def authenticate
    #  deny_access unless signed_in?
    #end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end

