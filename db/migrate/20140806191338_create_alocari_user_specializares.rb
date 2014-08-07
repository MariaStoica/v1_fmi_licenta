class CreateAlocariUserSpecializares < ActiveRecord::Migration
  def change
    create_table :alocari_user_specializares do |t|
      t.integer :user_id
      t.integer :specializare_id

      t.timestamps
    end
    add_index :alocari_user_specializares, :user_id
    add_index :alocari_user_specializares, :specializare_id
  end
end
