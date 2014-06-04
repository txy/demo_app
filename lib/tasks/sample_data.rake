namespace :db do
  desc "Fill database with sample data "
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end
#生成1个管理员用户和99个普通用户
def make_users
  admin = User.create!(name: "Example User",
                       email: "example@126.com",
                       password: "111111",
                       password_confirmation:  "111111",
                       admin: true)

  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@126.com" 
    password = "111111" 
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation:  password)
  end
end

def make_microposts
  #生成微博数据 给前6个用户生成50个微博
  users = User.all(limit:6 )
  50.times do  
    content = Faker::Lorem.sentence(5)
    users.each { |user| 
      user.microposts.create!(content: content) 
    }
  end 
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]  #关注组
  followers      = users[3..40]  #粉丝组
  followed_users.each {|followed| user.follow!(followed) } #创建关注组
  followers.each       {|follower| follower.follow!(user) } #创建粉丝组
end 

