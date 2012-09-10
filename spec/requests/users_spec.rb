require 'spec_helper'

describe "Users" do
  
  describe "signup" do
    
    describe "failure" do
      
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new') # in integration tests, we don't know in which controller we are at
          response.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
    end
    
    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Test User"
          fill_in "Email",        :with => "tester999@example.com"
          fill_in "Password",     :with => "password"
          fill_in "Confirmation", :with => "password"
          click_button
          response.should have_selector('div.flash.success',
                                        :content => "Welcome") # dots mean ids of a div
          response.should render_template('users/show') # in integration tests, we just follow the actions, without specifying which user ID we're seeing
        end.should change(User, :count).by(1)
      end
    end
  end
  
  describe "signin" do
    
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in "Email",      :with => ""
        fill_in "Password",   :with => ""
        click_button
        response.should have_selector('div.flash.error',
                                      :content => "Invalid")
        response.should render_template('sessions/new')
      end
    end
    
    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in "Email",    :with => user.email
        fill_in "Password", :with => user.password
        click_button
        conroller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
