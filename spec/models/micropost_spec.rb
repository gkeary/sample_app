# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Micropost do

  before(:each) do
    @user= Factory(:user)
    @attr= { content: "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @posting = @user.microposts.create(@attr)
    end

    it "should have a user attribute" do
       # Prints Michael Hartl  "value for content"
       #puts @posting.user.name, @posting.content
      @posting.should respond_to(:user)
    end

    it "should have the right associated user" do
      @posting.user_id.should == @user.id
      @posting.user.should == @user
    end
  end

  describe "validations" do

    it "should require a user_id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require non-blank content" do
      @user.microposts.build(content: "  ").should_not be_valid
        # microposts.build is essentially equivalent to Micropost.new,
        # except that it automatically sets 
        # the micropost’s user_id to @user.id.
    end

    it "should reject long content" do
      @user.microposts.build(content: "a" * 141).should_not be_valid
    end
  end
  
  describe "from_users_followed_by" do
      # This is the feed.
      #The purpose of a feed is to pull out the microposts 
      #    whose user ids correspond to the users 
      #    being followed by the current user 
      #    (and the current user itself).
    before(:each) do
      @other_user = Factory(:user, email: Factory.next(:email))
      @third_user = Factory(:user, email: Factory.next(:email))
  
      @user_post  = @user.microposts.create!( content: "foo")
      @other_post = @other_user.microposts.create!( content: "bar")
      @third_post = @third_user.microposts.create!( content: "baz")

      @user.follow!(@other_user)
    end

    it "should have a from_users_followed_by class method" do
      Micropost.should respond_to(:from_users_followed_by)
    end

    it "should include the followed user's microposts" do
      Micropost.from_users_followed_by(@user).should include(@other_post)
    end

    it "should include the user's own microposts" do
      Micropost.from_users_followed_by(@user).should include(@user_post)
    end

    it "should not include an unfollowed user's microposts" do
      Micropost.from_users_followed_by(@user).should_not include(@third_post)
    end
  end
end
