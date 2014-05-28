class CreateAnecdotes < ActiveRecord::Migration
  def change
    create_table :anecdotes do |t|
      t.string :sujet
      t.string :theme
      t.string :texte
      t.integer :user_id

      t.timestamps
    end
    add_index :anecdotes, [:sujet, :user_id]
  end
end
