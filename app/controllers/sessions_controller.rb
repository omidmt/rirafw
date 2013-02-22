class SessionsController < Backend::UnsecureController

  #self.default_home = root_path

  def new
    @title = "Sign in"
    @user = User.new
  end

  def create
    reset_session
    up = RSAHelper.decrypt params[:session][:cyph]
    email = up[ 0..up.index('|') - 1 ]
    passwd = up[ up.index('|') + 1..up.length ]
    user = User.authenticate( email, passwd )

    if user.nil?
      flash[:error] = "Invalid email/password combination."
      @title = "Sign in"
      Auditlog( self.class.name, "Login failed: #{email}" )
      redirect_to :signin

    elsif user.lock?
      flash[ :error ] = "Your account is locked, contact radmin."
      @title = "Sign in"
      Auditlog( self.class.name, "Login failed because of locked account: #{email}" )
      redirect_to :signin

    elsif user.expiry && user.expiry < Date.today
      flash[ :notice ] = "Your password is expired, please set new one."
      flash[ :user_email ] = user.email
      Auditlog( self.class.name, "Login succeed, expired password: #{email}" )
      redirect_to :chgpswd

    elsif user.account_expiry && user.account_expiry < Date.today
      flash[ :error ] = "Your account is expired."
      @title = "Sign in"
      Auditlog( self.class.name, "Login failed, because of expired account: #{email}" )
      redirect_to :signin

    else
      flash[ :success ] = "Welcome to ///RIRA"
      if params[ :session ][ :remember_me ].to_i == 1
        sign_in_remember( user )
      else
        sign_in( user )
      end
      Auditlog( self.class.name, "Login succeed: #{email}" )
      redirect_back_or home_path
    end
  end

  def destroy
    sign_out
    redirect_to :signin
  end

  def change_password
    @title = "Change Password"
    if !current_user.nil?
        @user = current_user
    elsif !flash[:user_email].nil?
      @user = User.find_by_email(flash[:user_email])
    else
      redirect_to :signin
    end
  end

  def update_password
    @user = User.find_by_email( params[:user][:email] )
    if User.authenticate( @user.email, params[:user][:old_password] )
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      @user.expiry = Date.today + Konfig::KONFIGS[ :passwordExpiryExtension ].days
      if @user.save
        sign_in @user
        flash[ :success ] = "Settings updated"
        redirect_back_or :home
      else
        render :change_password
      end
    else
      flash[:error] = "Invalid old password."
      redirect_to :signin
    end
  end

end
