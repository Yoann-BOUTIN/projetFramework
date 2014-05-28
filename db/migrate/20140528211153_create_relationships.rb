class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :personne
      t.integer :num_chap
      t.string :sujet
      t.string :lieu

      t.timestamps
    end
    add_index :relationships, :personne
    add_index :relationships, :num_chap
    add_index :relationships, :sujet
    add_index :relationships, :lieu
    add_index :relationships, [:personne, :num_chap, :sujet, :lieu], unique: true, :name => 'all_relation'
  end
end
