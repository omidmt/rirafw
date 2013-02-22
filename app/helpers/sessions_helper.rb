require 'date'

module SessionsHelper

  def sign_in_remember( user )
    #cookies.permanent.signed[ :remember_token ] = [ user.id, user.salt ]
    #session[ :user_id ] = user.id
    #current_user = user
    session[ :token ] = [ user.id, user.salt, request.remote_ip, 20.years.from_now ]
    self.current_user = user
  end

  #def sign_in_session( user )
  #  #cookies.signed[ :remember_token ] = [ user.id, user.salt ]
  #  #cookies[ :remember_token ] = { :value => [ user.id, user.salt ], :expires => 1.day.from_now }
  #  session[ :user_id ] = [ user.id, user.salt ]
  #  #request.session_options = request.session_options.dup
  #  #request.session_options[:expire_after]= 5.minutes
  #  #request.session_options.freeze
  #  #session[ :expire_after ] = 1.day.from_now
  #
  #  current_user = user
  #end
  #
  #def sign_out_session
  #  #cookies.delete(:remember_token)
  #  session[ :user_id ] = nil
  #  current_user = nil
  #end

  # Cookie base sign_in
  def sign_in( user )
    session[ :token ] = [ user.id, user.salt, request.remote_ip, Konfig::KONFIGS[ :sessionInactivityTimeout ].seconds.from_now ]
    self.current_user = user
  end

  # Cookie base sign_out
  def sign_out
    session.delete( :token )
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token_ip
    #@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !current_user.nil?
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  # Controller may implement this method internally to handle own authorization
  # mechanism. For sure the list of rights should be updated manually for each
  # right regardless of normal controller/action definition or internal controller
  # as mentioned above.

  def has_permission?( controller, action )
    #return true
    #puts "************* #{controller} - #{action} ******************"
    if (controller == 'home' && ( action == 'index' || action == 'launchpad' )) ||
        ( controller == 'user_settings' && (action == 'edit' || action == 'update' ))
      return true
    end

    current_user.rights.each do |right|
      if right.controller == controller && right.action == action
        return true
      end
    end
    return false
  end

  def deny_action( controller, action )
    if request.referer
      redirect_to( request.referer, :notice => "You don't have enough right on [#{controller}]" )
    else
      redirect_to( root_path, :notice => "You don't have enough right on [#{controller}]" )
    end
  end

  def redirect_back_or(default, notice=nil)
    redirect_to session[:return_to] || default, :notice => notice
    clear_return_to
  end

  def current_user?(user)
    user == current_user
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def authenticate
    deny_access unless signed_in?
  end

  def authorize
    deny_action(controller_name, action_name) unless has_permission?(controller_name, action_name)
    @apps = current_user.applets
  end

  def validate
    # validate license of controller and action
    #controller_name, action_name
  end

  private

    #def user_from_remember_token_depricated
    #  User.authenticate_with_salt( *userId_session )
    #end

    def user_from_remember_token_ip
      id, salt, ip, expiry = *userId
      #Applog.info "Expiry and remote IP : COOKIE=[#{expiry} #{ip}] SYS=[#{DateTime.current} #{request.remote_ip}]"
      #Applog.info "Expiry Checking=#{expiry > DateTime.current} IP Checking=#{ip == request.remote_ip}"
      if ( expiry && expiry > DateTime.current || Konfig::KONFIGS[ :sessionInactivityTimeout ] <= 0 ) && ip == request.remote_ip
        user = User.authenticate_with_salt( id, salt )
        # renew expiry of session because of new activity
        session[ :token ][ 3 ] = Konfig::KONFIGS[ :sessionInactivityTimeout ] > 0 ? Konfig::KONFIGS[ :sessionInactivityTimeout ].seconds.from_now : nil unless !user
        return user
      else
        #Applog.info "Expiry or remote IP is invalid, invalidating COOKIE=[#{expiry} #{ip}] SYS=[#{DateTime.current} #{request.remote_ip}]"
        return nil
      end
    end

    #def userId_session
    #  session[ :user_id ] || [ nil, nil ]
    #end

    # Get user information from cookie including userId, ip, salt
    # the order of information in array is as  user.id, user.salt, request.remote_ip, expiry
    def userId
      session[ :token ] || [ nil, nil, nil, nil ]
    end

    #def user_from_remember_token
    #  User.authenticate_with_salt(*remember_token)
    #end

    #def remember_token
    #  cookies.signed[:remember_token] || [nil, nil]
    #end

    def clear_return_to
      session[:return_to] = nil
    end

end
