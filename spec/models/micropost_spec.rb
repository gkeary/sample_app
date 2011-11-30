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
end