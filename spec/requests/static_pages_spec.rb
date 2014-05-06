require 'spec_helper'

describe "StaticPages" do 

  describe "Home page" do
    it "should hava the content 'Demo App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
  end

end
