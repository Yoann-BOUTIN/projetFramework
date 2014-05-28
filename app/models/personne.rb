class Personne < ActiveRecord::Base
  belongs_to :user
  has_many :scenes
  has_many :chapitres
  has_many :relationships, foreign_key: "personne", dependent: :destroy
  has_many :places, through: :relationships, source: :place
  has_many :chapter_number, through: :relationships, source: :chap_number
  default_scope -> { order('nom DESC') }
  validates :user_id, presence: true
  validates :nom, presence: true, length: { maximum: 40 }

  def following_chapter?(chapter)
    relationships.find_by(num_chap: chapter.num_chap)
  end

  def follow_chapter!(chapter)
    relationships.create!(num_chap: chapter.num_chap)
  end

  def unfollow_chapter!(chapter)
    relationships.find_by(num_chap: chapter.num_chap).destroy
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
end
