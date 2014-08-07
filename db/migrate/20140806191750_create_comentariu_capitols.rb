class CreateComentariuCapitols < ActiveRecord::Migration
  def change
    create_table :comentariu_capitols do |t|
      t.integer :user_id
      t.integer :capitol_id
      t.text :continut

      t.timestamps
    end
    add_index :comentariu_capitols, :user_id
    add_index :comentariu_capitols, :capitol_id
  end
end
