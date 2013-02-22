require 'spec_helper'

describe UserSettingsController do

  describe "for signed-in users" do

    before(:each) do
      wrong_user = FactoryGirl.create(:user, :email => "user@example.net")
      @user = FactoryGirl.create(:user)
      @wrngUser = test_sign_in(wrong_user)
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get :edit, :id => @wrngUser
        response.response_code.should == 200
        response.should be_success
      end
    end

    it "should require matching users for 'edit'" do
      get :edit, :id => @user
      response.should redirect_to(root_path)
    end

    it "should require matching users for 'update'" do
      put :update, :id => @user, :user => {}
      response.should redirect_to(root_path)
    end

  end

end
