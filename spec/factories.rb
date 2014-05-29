FactoryGirl.define do
  #factory :user do 
  #  name   "Michael Hartl"  
  #  email  "Michael@example.com" 
  #  password  "foobar" 
  #  password_confirmation  "foobar"
  #end
  factory :user do 
    sequence(:name) {|n| "Person #{n}" }  
    sequence(:email) {|n| "Person_#{n}@example.com" }  
    password  "foobar" 
    password_confirmation  "foobar"
    
    factory :admin do 
      admin true
    end
  end

  factory :micropost do 
    content   "Lorem ipsum"  
    user
  end
end
