class Anecdote < ActiveRecord::Base
  belongs_to :user
  belongs_to :chapitre
  has_many :relationships, foreign_key: "sujet", dependent: :destroy
  has_many :chapter_number, through: :relationships, source: :chap_number
  has_many :reverse_relationships, foreign_key: "num_chap",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  default_scope -> { order('sujet DESC') }
  validates :user_id, presence: true
  validates :sujet, presence: true, length: { maximum: 100 }
  validates :theme, presence: true
  validates :texte, presence: true

  def following?(chapter)
    relationships.find_by(num_chap: chapter.num_chap)
  end

  def follow!(chapter)
    relationships.create!(num_chap: chapter.num_chap)
  end

  def unfollow!(chapter)
    relationships.find_by(num_chap: chapter.num_chap).destroy
  end
end
