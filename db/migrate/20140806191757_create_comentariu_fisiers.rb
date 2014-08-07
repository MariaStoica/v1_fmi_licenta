class CreateComentariuFisiers < ActiveRecord::Migration
  def change
    create_table :comentariu_fisiers do |t|
      t.integer :user_id
      t.integer :fisier_id
      t.text :continut

      t.timestamps
    end
    add_index :comentariu_fisiers, :user_id
    add_index :comentariu_fisiers, :fisier_id
  end
end
