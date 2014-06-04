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
      it {should_not have_title('Profile')} 
      it {should_not have_title('Setting')} 
      it {should_not have_title('Sign out')} 
      #查找标签<div class = "alert alert-error"> ... </div> 内容
      #it {should have_selector('div.alert.alert-error')} 
      describe "after visiting another page" do 
        before {click_link "Home" }  
        it {should_not have_selector('div.alert.alert-error')} 
      end
    end
    #登录成功测试
    describe "with valid information" do   
      let(:user) { FactoryGirl.create(:user) }
      #before do
      #  fill_in "Email",                  with: user.email.upcase
      #  fill_in "Password",               with: user.password
      #  click_button "Sign in"
      #end 
      before {sign_in user }
      it {should have_title(user.name)} 
      it {should have_link('Users' ,       href: users_path ) } 
      it {should have_link('Profile' ,     href: user_path(user)) } 
      it {should have_link('Setting' ,     href: edit_user_path(user)) } 
      it {should have_link('Sign out' ,    href: signout_path) }  
      it {should_not have_link('Sign in' , href: signin_path) }  
    end
  end

  #权限测试
  describe "authorization" do   
    #不是管理员发送delete 页面操作
    describe "as non-admin user" do  
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      before {sign_in non_admin, no_capybara: true }
      describe "submitting a DELETE request to the Users#destrpy action" do  
        before {delete user_path(user) }
        specify {expect(response).to redirect_to(root_path) }
      end
    end

    #没有登录
    describe "for non-signed-in users" do  
      let(:user) { FactoryGirl.create(:user) }
      #测试Relationships的controller
      describe "in the Relationships controller" do
        #测试没有登录没有create Relationship权限
        describe "submitting to the create action" do 
          before {post relationships_path } 
          #post是否相应转向登录页面
          specify {expect(response).to redirect_to(signin_path) }
        end
        #测试没有登录没有destroy Relationship权限
        describe "submitting to the destroy action" do 
          before {delete relationship_path(1) }  
          specify {expect(response).to redirect_to(signin_path) }
        end
      end
      #测试Microposts的controller
      describe "in the Microposts controller" do
        #测试没有登录没有create Micropost权限
        describe "submitting to the create action" do 
          before {post microposts_path } 
          #post是否相应转向登录页面
          specify {expect(response).to redirect_to(signin_path) }
        end
        #测试没有登录没有destroy Micropost权限
        describe "submitting to the destroy action" do 
          before {delete micropost_path(FactoryGirl.create(:micropost) ) }  
          specify {expect(response).to redirect_to(signin_path) }
        end
      end
      describe "in the Users controller" do  
        #测试没有登录没有following权限
        describe "visiting the following page" do 
          before {visit following_user_path(user) }
          it {should have_title('Sign in')} 
        end 
        #测试没有登录没有 followers 权限
        describe "visiting the followers page" do 
          before {visit followers_user_path(user) }
          it {should have_title('Sign in')} 
        end 
        #测试没有登录没有edit权限
        describe "visiting the edit page" do 
          before {visit edit_user_path(user) }
          it {should have_title('Sign in')} 
        end 
        #测试没有登录没有update权限
        describe "submitting to the update action" do 
          before {put user_path(user) } 
          #put是否相应转向登录页面
          specify {expect(response).to redirect_to(signin_path) }
        end
        #测试没有登录没有index权限
        describe "submitting to the index action" do 
          before {visit users_path } 
          it {should have_title('Sign in')} 
        end
      end
      #点击保护页面测试
      describe "when attempting to visit a protected page" do  
        before do
          visit edit_user_path(user)   
          fill_in "Email",                 with: user.email
          fill_in "Password",              with: user.password 
          click_button "Sign in"
        end
        # 
        describe "after signing in" do 
          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
          describe "when signing in again" do 
            before do
              click_link "Sign out"
              visit signin_path  
              fill_in "Email",                 with: user.email
              fill_in "Password",              with: user.password 
              click_button "Sign in"
            end
            it "should render the default (profile) page" do
              expect(page).to have_title(user.name)
            end  
          end
        end  
      end
    end

    #修改其他用户资料
    describe "as wrong user" do  
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user,email: "wrong@example.com") }
      before {sign_in user ,no_capybara: true}
      describe "submitting a GET request to the Users#edit action" do 
        before {get edit_user_path(wrong_user) } 
        specify {expect(response.body).not_to match(full_title('Edit user'))}
        specify {expect(response).to redirect_to(root_path)}
      end
      describe "submitting a PUT request to the Users#update action" do 
        before {put user_path(wrong_user) }  
        specify {expect(response).to redirect_to(root_path)}
      end
    end 

  end 
end


































