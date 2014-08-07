class CreateAlegeriUserTemas < ActiveRecord::Migration
  def change
    create_table :alegeri_user_temas do |t|
      t.integer :user_id
      t.integer :tema_id
      t.string :status_profesor
      t.string :status_student
      t.integer :sesiune_id

      t.timestamps
    end
    add_index :alegeri_user_temas, :user_id
    add_index :alegeri_user_temas, :tema_id
    add_index :alegeri_user_temas, :sesiune_id
  end
end
