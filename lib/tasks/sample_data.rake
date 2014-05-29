namespace :db do
  desc "Fill database with sample data "
  task populate: :environment do
    User.create!(name: "Example User",
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

    #生成微博数据 给前6个用户生成50个微博
    users = User.all(limit:6 )
    50.times do  
      content = Faker::Lorem.sentence(5)
      users.each { |user| 
        user.microposts.create!(content: content) 
      }
    end 

  end
end
