require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
	it "should have the content 'Projet BOUTIN Yoann'" do
		visit '/static_pages/home'
		expect(page).to have_content('Projet BOUTIN Yoann')
	end
	it "should have the title 'Acceuil'" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails | Acceuil")
    end
  end
  describe "Help page" do

    it "should have the content 'Aide'" do
      visit '/static_pages/help'
      expect(page).to have_content('Aide')
    end
    it "should have the title 'Aide'" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails | Aide")
    end
  end
  describe "About page" do

    it "should have the content 'A propos'" do
      visit '/static_pages/about'
      expect(page).to have_content('A propos')
    end
    it "should have the title 'A propos'" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails | A propos")
    end
  end
end
