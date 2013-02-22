class UserMailer < ActionMailer::Base
  default from: "rira@rira.app"

  def welcome_email( user )
    attachments.inline[ 'rira.png' ] = File.read( 'app/assets/images/logo-256.png' )
    @user = user
    @hostAddress = Konfig::KONFIGS[ :accessProtocol ] + '://' + Konfig::KONFIGS[ :hostName ]
    mail( :to => user.email, :subject => 'RIRA Account' )
  end

end
