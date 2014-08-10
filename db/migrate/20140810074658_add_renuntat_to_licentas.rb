class AddRenuntatToLicentas < ActiveRecord::Migration
  def change
    add_column :licentas, :renuntat, :boolean
  end
end
