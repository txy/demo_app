require 'spec_helper'

describe "User" do
  #创建一个用户对象
  before do
    @user = User.new(name: "Example User" , 
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end
  #测试对象为@user
  subject { @user }

  it {should respond_to(:name)}  #存在性测试 字段是否存在
  it {should respond_to(:email)} #存在性测试 字段是否存在
  it {should respond_to(:password_digest)} #存在性测试 字段是否存在
  it {should respond_to(:password)} #存在性测试 字段是否存在
  it {should respond_to(:password_confirmation)} #存在性测试 字段是否存在
  it {should respond_to(:remember_token)} #存在性测试 字段是否存在
  it {should respond_to(:authenticate)} #能够响应authenticate
  it {should respond_to(:admin)} #存在性测试 字段是否存在
  it {should respond_to(:microposts)} #存在性测试 字段是否存在
  it {should respond_to(:feed)} #存在性测试 字段是否存在
  it {should respond_to(:relationships)} #存在性测试 字段是否存在
  it {should respond_to(:followed_users)} #存在性测试 字段（被关注）是否存在
  it {should respond_to(:following? )} #存在性测试 following?（是否关注）方法是否存在
  it {should respond_to(:follow!)} #存在性测试 follow!（创建关注）方法是否存在
  it {should respond_to(:unfollow!)} #存在性测试 follow!（取消关注）方法是否存在
  it {should respond_to(:reverse_relationships)} #存在性测试 reverse_relationships（粉丝）列表是否存在
  it {should respond_to(:followers)} #存在性测试 followers（粉丝）列表是否存在
  it {should be_valid} # 测试@user有效
  it {should_not be_admin} #测试是否是管理员
  #创建关注测试
  describe "following" do
    let!(:other_user) do
      FactoryGirl.create(:user)
    end
    before do
      @user.save
      @user.follow!(other_user)
    end 
    it {should be_following(other_user) } #被关注 other_user
    its(:followed_users) {should include(other_user)} #被关注用户包含other_user
    describe "followed user" do
      subject { other_user }
      its(:followers) {should include(@user)} #粉丝包含user
    end
    describe "and unfollowing" do
      before {@user.unfollow!(other_user)}
      it {should_not be_following(other_user) } #被关注 other_user
      its(:followed_users) {should_not include(other_user)} #被关注用户包含other_user
    end
  end

  #测试微博次序
  describe "micropost associations" do
    before do
      @user.save
    end 
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end 
    #测试微博次序
    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [newer_micropost,older_micropost]
    end
    #删除用户后用户微博也删除掉了
    it "should destroy associated microposts" do
      microposts = @user.microposts.to_a  #复制@user.microposts给microposts
      @user.destroy                       #删除用户
      expect(microposts).not_to be_empty  #microposts不为空
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty  #Micropost中找不到对应的microposts
      end
    end
    #只显示登录用户的微博，不显示其他用户的微博
    describe "status" do
      let!(:unfollowed_post) do 
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end 
      let(:followed_user) do 
        FactoryGirl.create(:user)
      end 
      before do
        @user.follow!(followed_user)
        3.times{followed_user.microposts.create!(content: "Lorem ipsum") }
      end 


      its(:feed) {should include(newer_micropost) }
      its(:feed) {should include(older_micropost) }
      its(:feed) {should_not include(unfollowed_post) }
      its(:feed) do 
        followed_user.microposts.each do |micropost|
          should  include(micropost)  
        end
      end
    end
  end 
  #管理员权限判断
  describe "with admin attribute set to 'true' " do
    before do
      @user.save!
      @user.toggle!(:admin)
    end 
    it {should be_admin} #测试是否是管理员
  end 
  #测试邮箱满足格式要求
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.org frst.lst@foo.jp
                     a+b@bar.cn ]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end 
  #测试邮箱是否唯一（不区分大小写）
  describe "when email address is already taken" do
    before do
      user_with_smae_email = @user.dup
      user_with_smae_email.email = @user.email.upcase
      user_with_smae_email.save
    end

    it {should_not be_valid}  
  end 
 
  #测试邮箱保存到数据库中转换为小写
  describe "email address with mixed case" do
    let(:mixed_case_email) {"Foo@ExAMPle.coM"}
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user_reload = User.find_by_id(@user.id)
      expect(@user_reload.email).to eq mixed_case_email.downcase
    end 
  end 
  #测试密码是否正确
  describe "return value of authenticate method " do
    #保存
    before do
      @user.save
    end
    let(:found_user) {User.find_by_email(@user.email)}
    #密码正确
    describe "with valid password " do
      it {should eq found_user.authenticate(@user.password) }  
    end
    #密码错误
    describe "with invalid password " do 
      let(:user_for_invalid_password) {found_user.authenticate("invalid")}
      it {should_not eq user_for_invalid_password }  
      specify {expect(user_for_invalid_password).to be_false }
    end
  end 
  #密码长度不能小于6位
  describe "with a password that's too short" do
    before {@user.password = @user.password_confirmation = "a" * 5}
    it {should be_invalid}  
  end
  #失败性校验
  describe "when name is not present" do
    before {@user.name = " "}
    it {should_not be_valid} # 测试@user.name为空
  end
  describe "when email is not present" do
    before {@user.email = " "}
    it {should_not be_valid} # 测试@user.email为空
  end
  describe "when name is too long" do
    before {@user.name = "a" * 51 }
    it {should_not be_valid} # 测试@user.name长度51位
  end
  #email不符合格式
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@var..com
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end 
  #密码为空
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User" , 
                     email: "user@example.com",
                     password: " ",
                     password_confirmation: " ")
    end 
    it {should_not be_valid } 
  end 

  #密码和确认密码不一致
  describe "when password doesn't match confirmation" do
    before do
      @user.password_confirmation = "mismatch" 
    end  
    it {should_not be_valid } 
  end 

  #
  describe "remember token" do
    before do
      @user.save
    end  
    its(:remember_token) {should_not be_blank} #等同 it {expect(@user.remember_token).not_to be_blank}

  end  
end
