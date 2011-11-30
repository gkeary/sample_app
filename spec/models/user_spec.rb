# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#


require 'spec_helper'

describe User do
  before(:each) do
    @attr = { 
              name: "Example User",
              email: 'user@example.com',
              password: 'foobar',
              password_confirmation: 'foobar'
             }
  end

  it "should create a new instance when given valid attributes" do
    User.create!(@attr) # create! throws when it fails
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(name: ""))
    no_name_user.should_not be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(email: ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(name: long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user=User.new(@attr.merge(email: address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user=User.new(@attr.merge(email: address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    # put a user with a duplcate email address into the database
    User.create!(@attr) #Using create w/o the bang risks bugs if the db already has that email.
    user_with_duplicate_email= User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge( password: "", password_confirmation: "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge( password_confirmation: "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge( password: short, password_confirmation: short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge( password: long, password_confirmation: long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
  end

  describe "has_password? method" do
      before(:each) do
        @user = User.create!(@attr)
      end

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
   end

  describe "authenticate method" do
    it "should return nil on email/password mismatch" do
      wrong_password_user = User.authenticate(@attr[:email],"wrongpass")
      wrong_password_user.should be_nil
    end

    it "should return nil for an email_address with no user" do
      nonexistant_user = User.authenticate("bar@foo.com", @attr[:password])
      nonexistant_user.should be_nil
    end

    it "should return the user on email/password match" do
      matching_user = User.authenticate(@attr[:email], @attr[:password])
      matching_user.should == @user
    end
  end

  describe "admin attribute" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be admin by default" do
      @user.should_not be_admin
    end

    it "should be convertable to admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
#
#Method	                      Purpose
#micropost.user             	Return the User object associated with the micropost.
#user.microposts            	Return an array of the user’s microposts.
#user.microposts.create(arg )	Create a micropost (user_id = user.id).
#user.microposts.create!(arg)	Create a micropost (exception on failure).
#user.microposts.build(arg)	  Return a new Micropost object (user_id = user.id).
#

  describe "micropost associations (for User)" do
    before(:each) do
      @user = User.create(@attr)
      @mp1= Factory(:micropost, user: @user, created_at: 1.day.ago)
      @mp1= Factory(:micropost, user: @user, created_at: 1.day.ago)
    end

    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end

    it "should have the right microposts in the right order" do
      @user.microposts.should == [@mp2, @mp1]
    end
  end
end
