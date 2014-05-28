class Personne < ActiveRecord::Base
  belongs_to :user
  has_many :scenes
  default_scope -> { order('nom DESC') }
  validates :user_id, presence: true
  validates :nom, presence: true, length: { maximum: 40 }
end