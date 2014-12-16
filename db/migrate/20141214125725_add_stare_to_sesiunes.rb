class AddStareToSesiunes < ActiveRecord::Migration
  def change
    add_column :sesiunes, :este_deschisa, :boolean
  end
end
