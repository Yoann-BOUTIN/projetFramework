class CreateChapitres < ActiveRecord::Migration
  def change
    create_table :chapitres do |t|
      t.integer :num_chap
      t.string :titre
      t.string :scene
      t.string :anecdote
      t.string :personne
      t.integer :user_id

      t.timestamps
    end
    add_index :chapitres, [:num_chap, :user_id]
  end
end
