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
  end
end
