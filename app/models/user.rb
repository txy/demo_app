class User < ActiveRecord::Base
  before_save { self.email =email.downcase } 
  before_create :create_remember_token
  #另一种写法 
  #before_save{email.downcase!}
  attr_accessible :email, :name ,:password,:password_confirmation,
                  :password_digest,:admin #定义属性访问器、获取和设定的方法
  validates :name, presence: true,   #validates(:name,presence: true)   非空
                   length: {maximum: 50} #长度50
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i   
  VALID_EMAIL_REGEX  = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,  #validates(:email,presence: true)  非空
                    format: { with: VALID_EMAIL_REGEX }, #邮箱格式
                    uniqueness: {case_sensitive: false} #唯一性 不区分大小写 
  validates :password, length: {minimum: 6} #最小长度6
  has_many :microposts ,dependent: :destroy#user与 Microposts 1:n 删除user则删除对应的Microposts
  has_secure_password

  def feed
    Micropost.where("user_id = ?",id)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  private 
    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
