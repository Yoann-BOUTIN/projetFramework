class Chapitre < ActiveRecord::Base
  belongs_to :user
  has_many :personnes
  has_many :scenes
  has_many :anecdotes
  has_many :relationships, foreign_key: "num_chap", dependent: :destroy
  has_many :places, through: :relationships, source: :place
  has_many :characters, through: :relationships, source: :character
  has_many :subjects, through: :relationships, source: :subject
  default_scope -> { order('num_chap DESC') }
  validates :user_id, presence: true
  validates :num_chap, presence: true, length: { maximum: 3 }
  validates :titre, presence: true, length: { maximum: 20 }

  def following_personne?(other_personne)
    relationships.find_by(personne: other_personne.nom)
  end

  def follow_personne!(other_personne)
    relationships.create!(personne: other_personne.nom)
  end

  def unfollow_personne!(other_personne)
    relationships.find_by(personne: other_personne.nom).destroy
  end

  def following_scene?(other_scene)
    relationships.find_by(lieu: other_scene.lieu)
  end

  def follow_scene!(other_scene)
    relationships.create!(lieu: other_scene.lieu)
  end

  def unfollow_scene!(other_scene)
    relationships.find_by(lieu: other_scene.lieu).destroy
  end

  def following_anecdote?(other_anecdote)
    relationships.find_by(sujet: other_anecdote.sujet)
  end

  def follow_anecdote!(other_anecdote)
    relationships.create!(sujet: other_anecdote.sujet)
  end

  def unfollow_anecdote!(other_anecdote)
    relationships.find_by(sujet: other_anecdote.sujet).destroy
  end
end
