require 'spec_helper'

describe "PersonnePages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "personne creation" do
    before { visit personne_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Valider" }.not_to change(Personne, :count)
      end

    end

    describe "with valid information" do

      before { fill_in 'personne_nom', with: "nom" }
      it "should create a micropost" do
        expect { click_button "Valider" }.to change(Personne, :count).by(1)
      end
    end
  end
end
