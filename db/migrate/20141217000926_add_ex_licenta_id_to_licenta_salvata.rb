class AddExLicentaIdToLicentaSalvata < ActiveRecord::Migration
  def change
    add_column :licenta_salvatas, :ex_licenta_id, :integer
  end
end
