class AddSesiuneIdToLicentas < ActiveRecord::Migration
  def change
    add_column :licentas, :sesiune_id, :integer
  end
end
