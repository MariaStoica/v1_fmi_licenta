class AddSpecializareToUsers < ActiveRecord::Migration
  def change
    add_column :users, :specializare, :string
  end
end
