class RemoveNumarFromDeadlines < ActiveRecord::Migration
  def change
  	remove_column :deadlines, :numar, :integer
  end
end
