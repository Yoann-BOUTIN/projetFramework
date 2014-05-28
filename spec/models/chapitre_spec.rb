require 'spec_helper'

describe Chapitre do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @chapitre = Chapitre.new(num_chap: "1", titre: "titre", scene: "scene", anecdote: "anecdote", personne: "personne", user_id: user.id)
  end

  subject { @chapitre }

  it { should respond_to(:num_chap) }
  it { should respond_to(:titre) }
  it { should respond_to(:scene) }
  it { should respond_to(:anecdote) }
  it { should respond_to(:personne) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @chapitre.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank num_chap" do
    before { @chapitre.num_chap = " " }
    it { should_not be_valid }
  end

  describe "with blank titre" do
    before { @chapitre.titre = " " }
    it { should_not be_valid }
  end

  describe "with num_chap that is too long" do
    before { @chapitre.num_chap = "1111" }
    it { should_not be_valid }
  end

  describe "with titre that is too long" do
    before { @chapitre.titre = "a" * 21 }
    it { should_not be_valid }
  end
end
