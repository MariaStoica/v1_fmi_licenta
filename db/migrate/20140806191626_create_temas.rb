class CreateTemas < ActiveRecord::Migration
  def change
    create_table :temas do |t|
      t.string :nume
      t.text :descriere
      t.integer :domeniu_id
      t.boolean :este_libera
      t.integer :user_id
      t.integer :sesiune_id

      t.timestamps
    end
    add_index :temas, :domeniu_id
    add_index :temas, :user_id
    add_index :temas, :sesiune_id
  end
end
