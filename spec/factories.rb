FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
  
  factory :anecdote do
    sujet "Sujet"
    theme "Theme"
    texte "Texte"
    user
  end

  factory :chapitre do
    num_chap "1"
    titre "Titre"
    scene "Scene"
    anecdote "Anecdote"
    personne "Personne"
    user
  end

  factory :personne do
    nom "Nom"
    first_chap "1"
    scene "Scene"
    user
  end
  
  factory :scene do
    lieu "Lieu"
    date "Date"
    recit "Recit"
    personne "Personne"
    user
  end
end
