require 'spec_helper'

describe "Micropost" do
  #创建用户对象
  let(:user) { FactoryGirl.create(:user) }
  #创建用户微博
  before do
    #@micropost = Micropost.new(content: "Lorem ipsum" , user_id: user.id )
    @micropost = user.microposts.build(content: "Lorem ipsum")
  end
  #测试对象为@micropost
  subject { @micropost }

  it {should respond_to(:content)}  #存在性测试 字段是否存在
  it {should respond_to(:user_id)} #存在性测试 字段是否存在 
  it {should be_valid} # 测试@micropost有效
  it {should respond_to(:user)} #存在性测试 字段是否存在 micropost.user存在
  its(:user) {should eq user } # 相当于 micropost.user == user
    
  #用户id为空测试
  describe "when user_id is not present " do
    before do
      @micropost.user_id = nil
    end 
    it {should_not be_valid}
  end 

  #用户content为空测试
  describe "with blank content" do
    before do
      @micropost.content= " "
    end 
    it {should_not be_valid}
  end 
  #用户content长度测试
  describe "with content that is too long" do
    before do
      @micropost.content= "a" * 141
    end 
    it {should_not be_valid}
  end 

end
