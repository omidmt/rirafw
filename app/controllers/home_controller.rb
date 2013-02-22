class HomeController < Backend::SecureController

  def launchpad
    @title = "Home"
  end

  def index
    @title = "Home"
    # Check konfig for default homepage
    #puts '****', Rails.application.routes.recognize_path( Konfig::KONFIGS[ :default_homepage ] ), '*****'
    begin
      if Konfig::KONFIGS[ :defaultHomePage ]
        route = Rails.application.routes.recognize_path Konfig::KONFIGS[ :defaultHomePage ]

        # Check to prevent looping redirect
        redirect_to Konfig::KONFIGS[ :defaultHomePage ] unless route[ :controller ] == "home" && route[ :action ] == "index"

      end
    rescue
      Applog.error "defaultHomePage doesn't match any valid route, check #{Konfig::KONFIGS[ :defaultHomePage ]}"
    end

  end

end
