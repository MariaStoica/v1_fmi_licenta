class AddEsteLicentaFinalaToCapitols < ActiveRecord::Migration
  def change
    add_column :capitols, :este_licenta_finala, :boolean
  end
end
