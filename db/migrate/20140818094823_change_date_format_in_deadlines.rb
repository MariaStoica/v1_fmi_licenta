class ChangeDateFormatInDeadlines < ActiveRecord::Migration
  def up
    change_column :deadlines, :data_start, :date
    change_column :deadlines, :data_end,   :date
  end

  def down
    change_column :deadlines, :data_start, :datetime
    change_column :deadlines, :data_end,   :datetime
  end
end
