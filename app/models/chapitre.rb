class Chapitre < ActiveRecord::Base
  belongs_to :user
  has_many :personnes
  has_many :scenes
  has_many :anecdotes
  default_scope -> { order('num_chap DESC') }
  validates :user_id, presence: true
  validates :num_chap, presence: true, length: { maximum: 3 }
  validates :titre, presence: true, length: { maximum: 20 }
end
