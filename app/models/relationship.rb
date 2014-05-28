class Relationship < ActiveRecord::Base
  belongs_to :character, class_name: "Personne"
  belongs_to :chap_number, class_name: "Chapitre"
  belongs_to :subject, class_name: "Anecdote"
  belongs_to :place, class_name: "Scene"
  validates :personne, presence: true
  validates :num_chap, presence: true
  validates :sujet, presence: true
  validates :lieu, presence: true
end
