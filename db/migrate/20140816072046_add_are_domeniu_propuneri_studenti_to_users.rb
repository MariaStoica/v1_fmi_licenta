class AddAreDomeniuPropuneriStudentiToUsers < ActiveRecord::Migration
  def change
    add_column :users, :are_domeniu_propuneri_studenti, :boolean
  end
end
