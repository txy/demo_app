require 'spec_helper'

describe "AuthenticatioPages" do
  subject { page } 
  #测试页面是否存在
  describe "signin page" do 
    before { visit signin_path  } 
    it {should have_title('Sign in')} 
    it {should have_content('Sign in')} 
  end 
  #测试登录
  describe "signin" do 
    before { visit signin_path  }  
    #登录失败测试
    describe "with invalid information" do  
      before { click_button "Sign in"  } 
      it {should have_title('Sign in')} 
      #查找标签<div class = "alert alert-error"> ... </div> 内容
      #it {should have_content('div.alert.alert-error')} 
      describe "after visiting another page" do 
        before {click_link "Home" }  
        it {should_not have_selector('div.alert.alert-error')} 
      end
    end
    #登录成功测试
    describe "with valid information" do   
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",                  with: user.email.upcase
        fill_in "Password",               with: user.password
        click_button "Sign in"
      end 
      it {should have_title(user.name)} 
      it {should have_link('Profile' ,     href: user_path(user)) } 
      it {should have_link('Sign out' ,    href: signout_path) }  
      it {should_not have_link('Sign in' , href: signin_path) } 

    end
  end
end


































