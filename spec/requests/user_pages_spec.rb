require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it {should have_content(user.name)} 
    it {should have_title(user.name)}

  end
  #测试注册页面
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" } 
    #注册失败
    describe "with invalid information" do 
      it "should not create a user " do 
        expect {click_button submit }.not_to change(User,:count)
        #另一种写法
        #inital = User.count
        #click_button "Create my account"
        #final = User.count
        #expect(inital).to eq final
      end 
      #测试错误提示
      describe "after submission" do 
        before {click_button submit } 
        it {should have_title('Sign up')} 
        it {should have_content('error')} 
      end
    end
    #注册成功
    describe "with valid information" do 
      before do
        fill_in "Name",                  with: "Example User"
        fill_in "Email",                 with: "user@example.com"
        fill_in "Password",              with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user " do 
        expect {click_button submit }.to change(User,:count).by(1)
      end
      #测试保存
      describe "after saving the user" do 
        before {click_button submit }
        let(:user) { User.find_by_email('user@example.com') }
        it {should have_link('Sign out')} 
        it {should have_title(user.name)} 
        it {should have_selector('div.alert-success',text:'Welcome' ) } 
      end
    end
  end
end
