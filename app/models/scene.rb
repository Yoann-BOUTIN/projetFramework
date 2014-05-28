class Scene < ActiveRecord::Base
  belongs_to :user
  has_many :personnes
  default_scope -> { order('lieu DESC') }
  validates :user_id, presence: true
  validates :recit, presence: true
  validates :lieu, presence: true, length: { maximum: 40 }
  validates :date, presence: true, length: { maximum: 60 }
end
