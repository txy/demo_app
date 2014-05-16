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
    end
  end
end
