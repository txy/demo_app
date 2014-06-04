require 'spec_helper'

describe Relationship do
  #创建follower对象
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }
  #测试对象为 relationship
  subject { relationship }
  it {should be_valid} # 测试relationship有效

  describe "follower methods " do
    it {should respond_to(:follower)} #存在性测试 字段是否存在
    it {should respond_to(:followed)} #存在性测试 字段是否存在
    its(:follower) {should eq follower } # 相当于 relationship.follower == follower
    its(:followed) {should eq followed } # 相当于 relationship.followed == followed
  end
  describe "when followed id is not present " do
    before {relationship.follower_id = nil}
    it {should_not be_valid}
  end
  describe "when follower id is not present " do
    before {relationship.follower_id = nil}
    it {should_not be_valid}
  end

end
