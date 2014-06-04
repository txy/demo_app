class Micropost < ActiveRecord::Base
  attr_accessible :content, :user_id
  validates :content , presence: true,  length: { maximum: 140 } #非空，长度140
  validates :user_id , presence: true
  belongs_to :user #user与 Microposts 1:n
  default_scope -> {order('created_at DESC') }

  def self.from_users_followed_by(user)
    #followed_user_ids = user.followed_user_ids 
    #where("user_id IN (?) OR user_id = ? ",followed_user_ids,user ) 
    #where("user_id IN (:followed_user_ids) OR user_id = user_id ",
    #   followed_user_ids: followed_user_ids,user_id: user )
    followed_user_ids = "SELECT followed_id FROM relationships WHERE  follower_id = :user_id " 
    where("user_id IN (#{followed_user_ids}) OR user_id = user_id ",
           user_id: user.id )
  end
end
 
