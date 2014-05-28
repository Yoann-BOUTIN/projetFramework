class Scene < ActiveRecord::Base
  belongs_to :user
  belongs_to :chapitre
  has_many :personnes
  has_many :relationships, foreign_key: "lieu", dependent: :destroy
  has_many :characters, through: :relationships, source: :character
  has_many :chapter_number, through: :relationships, source: :chap_number
  default_scope -> { order('lieu DESC') }
  validates :user_id, presence: true
  validates :recit, presence: true
  validates :lieu, presence: true, length: { maximum: 40 }
  validates :date, presence: true, length: { maximum: 60 }

  def following_chapter?(chapter)
    relationships.find_by(num_chap: chapter.num_chap)
  end

  def follow_chapter!(chapter)
    relationships.create!(num_chap: chapter.num_chap)
  end

  def unfollow_chapter!(chapter)
    relationships.find_by(num_chap: chapter.num_chap).destroy
  end

  def following_personne?(other_personne)
    relationships.find_by(other_personne: other_personne.nom)
  end

  def follow_personne!(other_personne)
    relationships.create!(personne: other_personne.nom)
  end

  def unfollow_personne!(other_personne)
    relationships.find_by(personne: other_personne.nom).destroy
  end
end
