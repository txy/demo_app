require 'spec_helper'

describe "Micropost Pages" do
  subject { page } 
  let(:user) { FactoryGirl.create(:user) }
  before {sign_in user }
  #micropost 删除
  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user)  }
    describe "as correct user" do
      before { visit root_path  }
      it "should delete a micropost" do  
        expect {click_link "delete"}.to change(Micropost, :count).by(-1)
      end 
    end
  end
  #micropost 创建
  describe "micropost creation" do
    before { visit root_path  }
    #micropost 创建成功测试
    describe "with valid information" do
      before do  
        fill_in "micropost_content",                 with: "Lorem ipsums"
      end
      #创建成功 微博数量加1
      it "should create a micropost" do  
        expect {click_button "Post"}.to change(Micropost, :count).by(1)
      end 
    end
    #micropost 创建失败测试
    describe "with invalid information" do
      #创建失败 微博数量不变
      it "should not create a micropost" do  
        expect {click_button "Post"}.not_to change(Micropost,:count)
      end
      #创建失败 有错误提示
      describe "error messages" do  
        before {click_button "Post"  } 
        it {should have_content('error') }
      end
    end
  end
end
