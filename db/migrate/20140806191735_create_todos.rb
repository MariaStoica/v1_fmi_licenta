class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.integer :capitol_id
      t.text :continut
      t.boolean :este_gata

      t.timestamps
    end
    add_index :todos, :capitol_id
  end
end
