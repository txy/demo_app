require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) do
      FactoryGirl.create(:micropost, user: user,content: "Foo" )
    end
    let!(:m2) do
      FactoryGirl.create(:micropost, user: user,content: "Bar" )
    end
    before { visit user_path(user) }

    it {should have_content(user.name)} 
    it {should have_title(user.name)}
    #测试用户微博信息
    describe "microposts" do   
      it {should have_content(m1.content)} 
      it {should have_content(m2.content)} 
      it {should have_content(user.microposts.count)} 
    end
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
  #编辑页面
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      sign_in user
      visit edit_user_path(user) 
    end
    #编辑页面内容
    describe "page" do 
      it {should have_content("Update your profile")}
      it {should have_title("Edit user")} 
      it {should have_link('change', href: 'http://gravatar/emails') } 
    end
    #保存失败
    describe "with invalid information" do 
      before { click_button "Save changes"}
      
      it {should have_content('error')}
    end
    #保存成功
    describe "with valid information" do 
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",                  with: new_name
        fill_in "Email",                 with: new_email
        fill_in "Password",              with: user.password
        fill_in "Confirmation",          with: user.password
        click_button "Save changes"
      end
      it {should have_title(new_name)} 
      it {should have_selector('div.alert.alert-success')} 
      it {should have_link('Sign out',href: signout_path)} 
      specify {expect(user.reload.name).to  eq new_name}
      specify {expect(user.reload.email).to eq new_email}
    end
    #测试管理员属性是否不能修改
    describe "with valid information" do 
      let(:params) do
        {user: {admin: true ,password: user.password,
               confirmation: user.password}} 
      end
      before {put user_path(user) ,params } 
      specify {expect(user.reload).not_to be_admin }
    end 
  end

  #index页面
  describe "index" do 
    let(:user) { FactoryGirl.create(:user) } 
    before(:each) do
      sign_in user  
      #FactoryGirl.create(:user, name: "Bob" , email: "bob@example.com") 
      #FactoryGirl.create(:user, name: "Ben" , email: "ben@example.com") 
      visit users_path
    end 

    it {should have_title("All users")} 
    it {should have_content("All users")}
    #分页测试
    describe "pagination" do
      before(:all) {30.times {FactoryGirl.create(:user) } }
      after(:all)  {User.delete_all }
      it {should have_selector("div.pagination")} 

      it "should list each user " do 
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
    #删除链接测试
    describe "delete links" do 
      it {should_not have_link("delete")}  
      describe "as an admin user" do   
        let(:admin) { FactoryGirl.create(:admin) } 
        before do
          sign_in admin   
          visit users_path
        end  
        it {should have_link("delete", href: user_path(User.first)) } 
        it "should be able to delete another user" do 
          expect do
            click_link('delete',match: :first)
          end.to change(User,:count).by(-1)
        end
        it {should_not have_link("delete",href: user_path(admin))} 
      end 
    end

  end

end
