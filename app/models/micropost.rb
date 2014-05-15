class Micropost < ActiveRecord::Base
  attr_accessible :conten, :user_id
  validates :conten ,  length: { maximum: 140 } 

  #belongs_to :user #user与 Microposts 1:n
end
 
