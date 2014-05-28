require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit users_path
    end

    it { should have_title('Tous les utilisateurs') }
    it { should have_content('Tous les utilisateurs') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('supprimer') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('supprimer', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('supprimer', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('supprimer', href: user_path(admin)) }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:anecdote, user: user, sujet: "sujet", theme: "theme", texte: "texte") }
    let!(:m2) { FactoryGirl.create(:anecdote, user: user, sujet: "sujets", theme: "themes", texte: "textes") }
    let!(:m3) { FactoryGirl.create(:chapitre, user: user, num_chap: "1", titre: "titre", scene: "scene", anecdote: "anecdote", personne: "personne") }
    let!(:m4) { FactoryGirl.create(:chapitre, user: user, num_chap: "2", titre: "titres", scene: "scenes", anecdote: "anecdotes", personne: "personnes") }
    let!(:m5) { FactoryGirl.create(:personne, user: user, nom: "nom", first_chap: "1", scene: "scene") }
    let!(:m6) { FactoryGirl.create(:personne, user: user, nom: "noms", first_chap: "2", scene: "scenes") }
    let!(:m7) { FactoryGirl.create(:scene, user: user, lieu: "lieu", date: "date", recit: "recit", personne: "personne") }
    let!(:m8) { FactoryGirl.create(:scene, user: user, lieu: "lieux", date: "dates", recit: "recits", personne: "personnes") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "anecdotes" do
      it { should have_content(m1.sujet) }
      it { should have_content(m1.theme) }
      it { should have_content(m1.texte) }
      it { should have_content(m2.sujet) }
      it { should have_content(m2.theme) }
      it { should have_content(m2.texte) }
      it { should have_content(user.anecdotes.count) }
    end

    describe "chapitres" do
      it { should have_content(m3.num_chap) }
      it { should have_content(m3.titre) }
      it { should have_content(m4.num_chap) }
      it { should have_content(m4.titre) }
      it { should have_content(user.chapitres.count) }
    end

    describe "personnes" do
      it { should have_content(m5.nom) }
      it { should have_content(m6.nom) }
      it { should have_content(user.personnes.count) }
    end

    describe "scenes" do
      it { should have_content(m7.lieu) }
      it { should have_content(m7.recit) }
      it { should have_content(m7.date) }
      it { should have_content(m8.lieu) }
      it { should have_content(m8.recit) }
      it { should have_content(m8.date) }
      it { should have_content(user.scenes.count) }
    end
  end
  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Inscription') }
    it { should have_title(full_title('Inscription')) }
  end
  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Creer mon compte" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Nom",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Mot de passe",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Deconnexion') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenue !') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Modifiez votre profil") }
      it { should have_title("Modification utilisateur") }
      it { should have_link('modifier', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Sauvegarder changements" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Nom",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Mot de passe",         with: user.password
        fill_in "Confirmer mot de passe", with: user.password
        click_button "Sauvegarder changements"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Deconnexion', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end