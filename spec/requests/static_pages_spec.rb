require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "Home page" do
    before { visit root_path }

    it { should have_content('Projet BOUTIN Yoann') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Acceuil') }
  end
  describe "Help page" do
    before { visit help_path }

    it { should have_content('Aide') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Aide') }
  end
  describe "About page" do
    before { visit about_path }

    it { should have_content('A propos') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| A propos') }
  end
end
