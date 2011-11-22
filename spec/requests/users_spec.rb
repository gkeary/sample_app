require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "failure" do
      
      it "should not make a new user" do
        visit signup_path
        fill_in "user_name",           with: ""
        fill_in "user_email",          with: ""
        fill_in "user_password",       with: ""
        fill_in "user_password_confirmation",   with: ""
        click_button
        response.should render_template('users/new')
        response.should have_selector("div#error_explanation")
      end
    end
  end
end
