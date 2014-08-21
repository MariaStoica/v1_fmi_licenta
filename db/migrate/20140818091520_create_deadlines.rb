class CreateDeadlines < ActiveRecord::Migration
  def change
    create_table :deadlines do |t|
      t.string :nume
      t.integer :numar
      t.text :descriere
      t.datetime :data_start
      t.datetime :data_end

      t.timestamps
    end
  end
end
