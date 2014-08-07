class CreateSpecializares < ActiveRecord::Migration
  def change
    create_table :specializares do |t|
      t.string :nume

      t.timestamps
    end
  end
end
