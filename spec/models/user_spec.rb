require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:anecdotes) }
  it { should respond_to(:personnes) }
  it { should respond_to(:scenes) }
  it { should respond_to(:chapitres) }
  it { should respond_to(:feed) }
  it { should respond_to(:feed_chapitre) }
  it { should respond_to(:feed_scene) }
  it { should respond_to(:feed_personne) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "anecdote associations" do

    before { @user.save }
    let!(:older_anecdote) do
      FactoryGirl.create(:anecdote, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_anecdote) do
      FactoryGirl.create(:anecdote, user: @user, created_at: 1.hour.ago)
    end

    it "should destroy associated anecdotes" do
      anecdotes = @user.anecdotes.to_a
      @user.destroy
      expect(anecdotes).not_to be_empty
      anecdotes.each do |anecdote|
        expect(Anecdote.where(id: anecdote.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:anecdote, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_anecdote) }
      its(:feed) { should include(older_anecdote) }
      its(:feed) { should_not include(unfollowed_post) }
    end
  end

  describe "chapitre associations" do

    before { @user.save }
    let!(:older_chapitre) do
      FactoryGirl.create(:chapitre, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_chapitre) do
      FactoryGirl.create(:chapitre, user: @user, created_at: 1.hour.ago)
    end

    it "should destroy associated chapitres" do
      chapitres = @user.chapitres.to_a
      @user.destroy
      expect(chapitres).not_to be_empty
      chapitres.each do |chapitre|
        expect(Chapitre.where(id: chapitre.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:chapitre, user: FactoryGirl.create(:user))
      end

      its(:feed_chapitre) { should include(newer_chapitre) }
      its(:feed_chapitre) { should include(older_chapitre) }
      its(:feed_chapitre) { should_not include(unfollowed_post) }
    end
  end
  
  describe "personne associations" do

    before { @user.save }
    let!(:older_personne) do
      FactoryGirl.create(:personne, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_personne) do
      FactoryGirl.create(:personne, user: @user, created_at: 1.hour.ago)
    end

    it "should destroy associated personnes" do
      personnes = @user.personnes.to_a
      @user.destroy
      expect(personnes).not_to be_empty
      personnes.each do |personne|
        expect(Personne.where(id: personne.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:personne, user: FactoryGirl.create(:user))
      end

      its(:feed_personne) { should include(newer_personne) }
      its(:feed_personne) { should include(older_personne) }
      its(:feed_personne) { should_not include(unfollowed_post) }
    end
  end

  describe "scene associations" do

    before { @user.save }
    let!(:older_scene) do
      FactoryGirl.create(:scene, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_scene) do
      FactoryGirl.create(:scene, user: @user, created_at: 1.hour.ago)
    end

    it "should destroy associated scenes" do
      scenes = @user.scenes.to_a
      @user.destroy
      expect(scenes).not_to be_empty
      scenes.each do |scene|
        expect(Scene.where(id: scene.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:scene, user: FactoryGirl.create(:user))
      end

      its(:feed_scene) { should include(newer_scene) }
      its(:feed_scene) { should include(older_scene) }
      its(:feed_scene) { should_not include(unfollowed_post) }
    end
  end
end
