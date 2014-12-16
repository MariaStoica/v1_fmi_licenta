class AddPublicTintaToDeadlines < ActiveRecord::Migration
  def change
    add_column :deadlines, :public_tinta, :string
  end
end
