class CreatePersonnes < ActiveRecord::Migration
  def change
    create_table :personnes do |t|
      t.string :nom
      t.integer :first_chap
      t.string :scene
      t.integer :user_id

      t.timestamps
    end
    add_index :personnes, [:first_chap, :user_id]
  end
end
