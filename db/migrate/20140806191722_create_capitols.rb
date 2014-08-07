class CreateCapitols < ActiveRecord::Migration
  def change
    create_table :capitols do |t|
      t.integer :licenta_id
      t.string :nume
      t.integer :numar

      t.timestamps
    end
    add_index :capitols, :licenta_id
  end
end
