require 'spec_helper'

describe "ChapitrePages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "chapitre creation" do
    before { visit chapitre_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Valider" }.not_to change(Chapitre, :count)
      end

    end

    describe "with valid information" do

      before { fill_in 'chapitre_num_chap', with: "1" }
      before { fill_in 'chapitre_titre', with: "titre" }
      it "should create a micropost" do
        expect { click_button "Valider" }.to change(Chapitre, :count).by(1)
      end
    end
  end
end
