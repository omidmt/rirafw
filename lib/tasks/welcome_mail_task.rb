class WelcomeMailTask < Task

  def initialize( user )
    @user = user
  end

  def perform
    UserMailer.welcome_email( @user ).deliver
  end

end
