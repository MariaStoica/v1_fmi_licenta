class CreateComentariuTemas < ActiveRecord::Migration
  def change
    create_table :comentariu_temas do |t|
      t.integer :user_id
      t.integer :tema_id
      t.text :continut

      t.timestamps
    end
    add_index :comentariu_temas, :user_id
    add_index :comentariu_temas, :tema_id
  end
end
