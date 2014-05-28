require 'spec_helper'

describe "AnecdotePages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "anecdote creation" do
    before { visit anecdote_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Valider" }.not_to change(Anecdote, :count)
      end

    end

    describe "with valid information" do

      before { fill_in 'anecdote_sujet', with: "sujet" }
      before { fill_in 'anecdote_theme', with: "theme" }
      before { fill_in 'anecdote_texte', with: "texte" }
      it "should create a micropost" do
        expect { click_button "Valider" }.to change(Anecdote, :count).by(1)
      end
    end
  end
end
