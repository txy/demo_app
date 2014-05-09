class User < ActiveRecord::Base
  attr_accessible :email, :name         #定义属性访问器、获取和设定的方法
  
  has_many :microposts #user与 Microposts 1:n
 
end
