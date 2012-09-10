require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user) # Creates a user based on the info in the factory
    end
    
    it "should be successful" do
      get :show, :id => @user.id
      response.should be_success
    end
    
    it "should find the correct user" do
      get :show, :id => @user.id
      assigns(:user).should == @user # Pulls out an instance of @user from the Users controller if it is assigned in the controller
    end
    
    it "should have the correct title" do
      get :show, :id => @user.id
      response.should have_selector('title', :content => @user.name)
    end
    
    it "should have the user's name" do
      get :show, :id => @user
      response.should have_selector('h1', :content => @user.name)
    end
    
    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector('h1>img', :class => "gravatar") # looks for the img tag between an h1 tag, with a class gravatar
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
    
    it "should have the correct title" do
      get :new
      response.should have_selector('title', :content => "Sign up" )
    end
  end
  
  describe "success" do
    
    before(:each) do
      @attr = { :name => "Test User", :email => "user@example.com",
                :password => "password", :password_confirmation => "password" }
    end
    
    it "should sign the user in" do
      post :create, :user => @attr
      controller.should be_signed_in
    end
  end

end