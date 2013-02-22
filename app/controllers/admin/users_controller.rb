require 'tasks/welcome_mail_task'

class Admin::UsersController < Backend::SecureController

  #before_filter :admin_user, :only => :destroy
  #include Util

  def index
    @title = "All Users"
    #@users = User.all
    @users = User.paginate(:page => params[:page])
    store_location
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name + " Profile"
  end

  def new
    @user = User.new
    @title = "New User"
  end

  def create
    @user = User.new()
    @user.name = params[ :user ][ :name ]
    @user.email = params[ :user ][ :email ]
    @user.password = params[ :user ][ :password ]
    @user.password_confirmation = params[ :user ][ :password_confirmation ]
    @user.expiry = params[ :user ][ :expiry ]
    @user.account_expiry = params[ :user ][ :account_expiry ]
    @user.lock = params[ :user ][ :lock ]
    @user.roles = Role.where( :id => params[ :user ][ :role_ids ] )

    if @user.save
      # It is not the case where admin has to confirm registration
      # sign_in @user
      Applog.info "New user is added #{@user.name} [#{@user.email}]]"
      flash[:success] = "User #{@user.email} is added to ///RIRA"

      # Add mailing process to background process
      Job.enqueue( :task => WelcomeMailTask.new( @user ),
                   :name => 'Welcome Email',
                   :userId => current_user.id,
                   :queue => Job::MAIL_DELIVERY_QUEUE,
                   :message => 'Waiting to deliver' )
      redirect_to admin_user_path(@user)
    else
      @title = "New User"
      render 'new'
    end

    Auditlog( self.class.name, @user )

  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User [#{user.name}] deleted."
    Applog.info "User #{user.name} [#{user.email}] deleted ]"
    Auditlog( self.class.name, user )
    redirect_to admin_users_path
  end

  def unlock
    user = User.find( params[ :id ] )
    user.update_attribute( :lock, false )
    user.update_attribute( :failed, 0 )
    Applog.info "User #{user.name} [#{user.email}] unloked"
    Auditlog( self.class.name, user )
    redirect_back_or admin_users_path
  end

  def lock
    user = User.find( params[ :id ] )
    user.update_attribute( :lock, true )
    Applog.info "User #{user.name} [#{user.email}] loked"
    Auditlog( self.class.name, user )
    redirect_back_or admin_users_path
  end

  def edit
    if @user.nil?
      @user = User.find( params[ :id ] )
    end
    @title = "Edit user #{@user.email}"
    @microposts = @user.microposts.paginate( :page => params[ :page ] )
    store_location
  end

  def update
    @user = User.find( params[ :id ] )

    #puts params[ :user ]

    @title = "Edit user #{@user.email}"
    @user.email = params[ :user ][ :email ]
    @user.name = params[ :user ][ :name ]
    @user.expiry = params[ :user ][ :expiry ]
    @user.account_expiry = params[ :user ][ :account_expiry ]
    @user.roles = Role.where( :id => params[ :user ][ :role_ids ] )


    if !params[ :user ][ :password ].nil? && !params[ :user ][ :password ].blank?
      @user.password = params[ :user ][ :password ]
      @user.password_confirmation = params[ :user ][ :password_confirmation ]
      if @user.save( :validate => true )
        Applog.info "User #{@user.name} [#{@user.email}] properties updated, include password"
        flash[:success] = "User settings updated [Password has been changed]"
      else
        render :edit
        return
      end
    else
      if @user.save( :validate => true )
        Applog.info "User #{@user.name} [#{@user.email}] properties updated"
        flash[:success] = "User settings updated."
      else
        render :edit
        return
      end
    end
    Auditlog( self.class.name, @user )
    redirect_back_or admin_users_path
    #render :edit
  end

end
