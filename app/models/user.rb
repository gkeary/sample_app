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

require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_many :microposts, dependent: :destroy 
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships,
                       source: :follower
                       

#Method	                        Purpose
#micropost.user                  Return the User object associated with the micropost.
#user.microposts                 Return an array of the user’s microposts.
#user.microposts.create(arg)     Create a micropost (user_id = user.id).
#user.microposts.create!(arg)    Create a micropost (exception on failure).
#user.microposts.build(arg)      Return a new Micropost object (user_id = user.id).
#


  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  :presence => true,
             :length => { :maximum => 50}
             
  validates :email,  presence: true,
            :format => {:with => email_regex } ,
            uniqueness: { case_sensitive: false}

  validates :password, presence: true,
                       confirmation: true,
                       length: { within: 6..40 }

  before_save :encrypt_password

  #Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

# ternary operator
def self.authenticate(email,submitted_password)
  user= find_by_email(email)
  user && user.has_password?(submitted_password) ? user : nil
end

def self.authenticate_with_salt(id, cookie_salt)
  user= find_by_id(id)
  (user && user.salt == cookie_salt) ? user : nil
end

def following?(followed) 
  relationships.find_by_followed_id(followed)
end 

def follow!(followed)
  relationships.create!(followed_id: followed.id)
end

def unfollow!(followed)
  relationships.find_by_followed_id(followed).destroy
end
  
def feed
  # This WAS preliminary. See Ch12 for the full implementation.
#Micropost.where("user_id = ?", id)
   Micropost.from_users_followed_by(self)
end

private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
