class Public::HelpController < Backend::UnsecureController

  def about
    @title = "About"
  end

  def help
    @title = 'Help'
  end

end
