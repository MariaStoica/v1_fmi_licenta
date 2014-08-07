class CreateDomenius < ActiveRecord::Migration
  def change
    create_table :domenius do |t|
      t.string :nume
      t.text :descriere
      t.integer :user_id

      t.timestamps
    end
    add_index :domenius, :user_id
  end
end
