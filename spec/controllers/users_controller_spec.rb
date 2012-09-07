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

end