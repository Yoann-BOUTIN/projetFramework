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

  describe "Anecdote page" do
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:anecdote, user: user, sujet: "sujet", theme: "theme", texte: "texte")
        FactoryGirl.create(:anecdote, user: user, sujet: "sujets", theme: "themes", texte: "textes")
        sign_in user
        visit anecdote_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.sujet)
          expect(page).to have_selector("li##{item.id}", text: item.theme)
          expect(page).to have_selector("li##{item.id}", text: item.texte)
        end
      end
    end
  end

  describe "Chapitre page" do
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:chapitre, user: user, num_chap: "1", titre: "titre", scene: "scene", anecdote: "anecdote", personne: "personne")
        FactoryGirl.create(:chapitre, user: user, num_chap: "2", titre: "titres", scene: "scenes", anecdote: "anecdotes", personne: "personnes")
        sign_in user
        visit chapitre_path
      end

      it "should render the user's feed" do
        user.feed_chapitre.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.num_chap)
          expect(page).to have_selector("li##{item.id}", text: item.titre)
        end
      end
    end
  end

  describe "Personne page" do
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:personne, user: user, nom: "nom", first_chap: "1", scene: "scene")
        FactoryGirl.create(:personne, user: user, nom: "noms", first_chap: "2", scene: "scenes")
        sign_in user
        visit personne_path
      end

      it "should render the user's feed" do
        user.feed_personne.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.nom)
        end
      end
    end
  end

  describe "Scene page" do
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:scene, user: user, lieu: "lieu", date: "date", recit: "recit", personne: "personne")
        FactoryGirl.create(:scene, user: user, lieu: "lieux", date: "dates", recit: "recits", personne: "personnes")
        sign_in user
        visit scene_path
      end

      it "should render the user's feed" do
        user.feed_scene.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.lieu)
          expect(page).to have_selector("li##{item.id}", text: item.recit)
          expect(page).to have_selector("li##{item.id}", text: item.date)
        end
      end
    end
  end
end
