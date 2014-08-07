class CreateLicentaSalvatas < ActiveRecord::Migration
  def change
    create_table :licenta_salvatas do |t|
      t.integer :user_id
      t.integer :tema_id
      t.integer :sesiune_id

      t.timestamps
    end
    add_index :licenta_salvatas, :user_id
    add_index :licenta_salvatas, :tema_id
    add_index :licenta_salvatas, :sesiune_id
  end
end
