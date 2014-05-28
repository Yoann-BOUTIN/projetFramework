require 'spec_helper'

describe Anecdote do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @anecdote = Anecdote.new(sujet: "test", theme: "test", texte: "test", user_id: user.id)
  end

  subject { @anecdote }

  it { should respond_to(:sujet) }
  it { should respond_to(:theme) }
  it { should respond_to(:texte) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:relationships) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @anecdote.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank sujet" do
    before { @anecdote.sujet = " " }
    it { should_not be_valid }
  end

  describe "with blank theme" do
    before { @anecdote.theme = " " }
    it { should_not be_valid }
  end
 
  describe "with blank texte" do
    before { @anecdote.texte = " " }
    it { should_not be_valid }
  end

  describe "with sujet that is too long" do
    before { @anecdote.sujet = "a" * 101 }
    it { should_not be_valid }
  end
end
