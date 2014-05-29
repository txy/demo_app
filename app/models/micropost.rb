class Micropost < ActiveRecord::Base
  attr_accessible :content, :user_id
  validates :content , presence: true,  length: { maximum: 140 } #非空，长度140
  validates :user_id , presence: true
  belongs_to :user #user与 Microposts 1:n
  default_scope -> {order('created_at DESC') }
end
 
