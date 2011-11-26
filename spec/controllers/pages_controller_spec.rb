require 'spec_helper'

describe PagesController do

  render_views

  boilerplate =  "Ruby on Rails Tutorial Sample App "
  pages= qw[home contact about]
  aa = {desc: 'home', desc: 'contact', desc: 'about'}
  its = {text: "should be successful", text: "should have the right title"}
  contents = {title: boilerplate + "| Home", 
             title: boilerplate + "| Contact",
             title: boilerplate + "| About"}

  vars = [aa, its, contents]
  
  

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title", 
            :content => "Ruby on Rails Tutorial Sample App | Home")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", 
            :content => "Ruby on Rails Tutorial Sample App | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    it "should have the right title" do
      get 'about'
      response.should have_selector("title", 
            :content => "Ruby on Rails Tutorial Sample App | About")
    end
  end
end
