require 'spec_helper'

describe Admin::UsersController do
  render_views

  describe "GET 'index'" do
    it "should deny access" do
      get :index
      response.should redirect_to(signin_path)
      flash[:notice].should =~ /sign in/i
    end

    it "should have admin in users index" do
      pending
      #get 'index'
      #response.should contain( "admin" )
    end

    describe "for signed-in users" do
      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        second = FactoryGirl.create(:user, :email => "another@example.com")
        third = FactoryGirl.create(:user, :email => "another@example.net")
        @users = [@user, second, third]
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All Users")
      end

      it "should have an element for each user" do
        get :index
        @users.each do |user|
          response.should have_selector("td", :content => user.name)
        end
      end
    end

  end

  describe "GET 'new'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in @user
    end

    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "New User")
    end
  end

  describe "Delete user" do
    it "returns http success" do
      pending
      # get :destroy, :id => @user
      # response.should be_succesful
      # redirect_to admin_users_path
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in @user
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h3", :content => @user.email)
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        test_sign_in @user
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "New User")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @user = FactoryGirl.create(:user)
        test_sign_in @user
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
        post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(admin_user_path(assigns(:user)))
      end

      it "should have a successful add flash" do
        post :create, :user => @attr
        print @attr
        flash[:success].should =~ /User #{@attr[:email]} is added to \/\/\/RIRA/i
      end

      it "should sign the user in" do
        post :create, :user => @attr
        #print "\nCurrent User: " + controller.current_user
        #controller.should be_signed_in
      end

    end
  end

  describe "GET 'edit'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit user")
    end

  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    describe "for non-signed-in users" do
      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end
  end

end
