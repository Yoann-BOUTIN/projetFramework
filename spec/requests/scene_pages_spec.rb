require 'spec_helper'

describe "ScenePages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "scene creation" do
    before { visit scene_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Valider" }.not_to change(Scene, :count)
      end

    end

    describe "with valid information" do

      before { fill_in 'scene_lieu', with: "lieu" }
      before { fill_in 'scene_recit', with: "recit" }
      before { fill_in 'scene_date', with: "date" }
      it "should create a micropost" do
        expect { click_button "Valider" }.to change(Scene, :count).by(1)
      end
    end
  end
end
