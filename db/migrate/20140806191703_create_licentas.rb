class CreateLicentas < ActiveRecord::Migration
  def change
    create_table :licentas do |t|
      t.integer :user_id
      t.integer :tema_id

      t.timestamps
    end
    add_index :licentas, :user_id
    add_index :licentas, :tema_id
  end
end
