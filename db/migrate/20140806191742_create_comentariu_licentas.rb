class CreateComentariuLicentas < ActiveRecord::Migration
  def change
    create_table :comentariu_licentas do |t|
      t.integer :user_id
      t.integer :licenta_id
      t.text :continut

      t.timestamps
    end
    add_index :comentariu_licentas, :user_id
    add_index :comentariu_licentas, :licenta_id
  end
end
