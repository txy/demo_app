require 'spec_helper'

describe "StaticPages" do 

  let(:base_title) {"Ruby on Rails Tutorial Demp App"}
  subject {page}
  describe "Home page" do
    before {visit root_path}
    
    it {should have_content('Demp App') } 
    it {should have_title(full_title('')) } 
    it {should_not have_title("| Home") }  
  end

  describe "Help page" do
    before {visit help_path}
    
    it {should have_content('Help') } 
    it {should have_title(full_title('Help')) }    
  end

  describe "About page" do
    it "should hava the content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end
    it "should hava the title 'About'" do
      visit about_path
      expect(page).to have_title("#{base_title} | About")
    end
  end

  describe "Contact page" do
    it "should hava the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end
    it "should hava the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("#{base_title} | Contact")
    end
  end
end
