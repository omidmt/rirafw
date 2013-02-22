require 'spec_helper'

describe HomeController do
  render_views

  describe "GET 'launchpad'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in @user
    end

    it "returns http success" do
      get 'launchpad'
      response.should be_success
    end
  end

  describe "GET 'home'" do
    #it "returns http success" do
    #  get 'home'
    #  response.should be_success
    #end
  end

end
