require 'spec_helper'

describe Scene do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @scene = Scene.new(lieu: "lieu", date: "date", recit: "recit", personne: "Personne", user_id: user.id)
  end

  subject { @scene }

  it { should respond_to(:lieu) }
  it { should respond_to(:date) }
  it { should respond_to(:recit) }
  it { should respond_to(:personne) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:relationships) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @scene.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank recit" do
    before { @scene.recit = " " }
    it { should_not be_valid }
  end

  describe "with blank lieu" do
    before { @scene.lieu = " " }
    it { should_not be_valid }
  end

  describe "with blank date" do
    before { @scene.date = " " }
    it { should_not be_valid }
  end

  describe "with lieu that is too long" do
    before { @scene.lieu = "a" * 41 }
    it { should_not be_valid }
  end

  describe "with date that is too long" do
    before { @scene.date = "a" * 61 }
    it { should_not be_valid }
  end
end
