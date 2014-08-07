class DropSpecializaresTable < ActiveRecord::Migration
  def change
  	drop_table :specializares
  	drop_table :alocari_user_specializares
  end
end
