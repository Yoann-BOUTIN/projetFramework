require 'spec_helper'

describe Personne do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @personne = Personne.new(nom: "Nom", first_chap: "1", scene: "test", user_id: user.id)
  end

  subject { @personne }

  it { should respond_to(:nom) }
  it { should respond_to(:first_chap) }
  it { should respond_to(:scene) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:relationships) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @personne.user_id = nil }
    it { should_not be_valid }
  end

   describe "with blank nom" do
    before { @personne.nom = " " }
    it { should_not be_valid }
  end

  describe "with nom that is too long" do
    before { @personne.nom = "a" * 41 }
    it { should_not be_valid }
  end
end
