require 'spec_helper'

describe Public::HelpController do

  describe "GET 'about'" do
    it "return http success" do
      get 'about'
      response.should be_success
    end

    it "return about in title" do
      get 'about'
      print response.body
      response.should have_selector( "title", :content => "About" )
    end
  end

end
