class Anecdote < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('sujet DESC') }
  validates :user_id, presence: true
  validates :sujet, presence: true, length: { maximum: 100 }
  validates :theme, presence: true
  validates :texte, presence: true
end
