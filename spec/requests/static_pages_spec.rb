require 'spec_helper'

describe "StaticPages" do 

  describe "Home page" do
    it "should hava the content 'Demo App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Demo App')
    end
    it "should hava the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Demp App | Home")
    end
  end
 


  describe "Help page" do
    it "should hava the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    it "should hava the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Demp App | Help")
    end
  end

  describe "About page" do
    it "should hava the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end
    it "should hava the title 'About'" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Demp App | About")
    end
  end
end
