class CreateFisiers < ActiveRecord::Migration
  def change
    create_table :fisiers do |t|
      t.string :name
      t.string :path
      t.date :adaugat
      t.integer :user_id
      t.integer :capitol_id

      t.timestamps
    end
    add_index :fisiers, :user_id
    add_index :fisiers, :capitol_id
  end
end
