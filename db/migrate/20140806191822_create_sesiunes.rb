class CreateSesiunes < ActiveRecord::Migration
  def change
    create_table :sesiunes do |t|
      t.date :data_start
      t.date :data_end

      t.timestamps
    end
  end
end
