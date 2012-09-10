require 'spec_helper'

describe "Users" do
  
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
