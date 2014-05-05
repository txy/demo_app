class User < ActiveRecord::Base
  attr_accessible :email, :name
 
  has_many :microposts #user与 Microposts 1:n
end
