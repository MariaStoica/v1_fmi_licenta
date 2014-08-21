class AddSesiuneIdToDomenius < ActiveRecord::Migration
  def change
    add_column :domenius, :sesiune_id, :integer
  end
end
