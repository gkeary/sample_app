namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
    admin = User.create!( name: "Gregg Keary", email: "gregg@gkeary.com",
                  password: "foobar", password_confirmation: "foobar")
    admin.toggle!(:admin)
    admin =User.create!( name: "Example User", email: "example@railstutorial.org",
                  password: "foobar", password_confirmation: "foobar")
    admin.toggle!(:admin)

    98.times do |n|
      name = Faker::Name.name
      email = "example-#{n-1}@railstutorial.org"
      password="foobar" #"password"
      User.create!( name: name, email: email,
                    password: password, password_confirmation: password)
    end
end

def make_microposts
  User.all(limit: 6).each do |u|
    50.times do 
      content = Faker::Lorem.sentence(5)
      u.microposts.create!(content: content)
    end
  end
end

# We somewhat arbitrarily arrange for 
#    the first user to follow the next 50 users, 
#     and then 
#   have users with ids 4 through 41 
#     follow that user back.
def make_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed)}
  followers.each { |follower| follower.follow!(user)}
end
