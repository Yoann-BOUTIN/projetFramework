class CreateScenes < ActiveRecord::Migration
  def change
    create_table :scenes do |t|
      t.string :lieu
      t.string :date
      t.string :recit
      t.string :personne
      t.integer :user_id

      t.timestamps
    end
    add_index :scenes, [:lieu, :user_id]
  end
end
