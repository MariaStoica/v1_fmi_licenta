class ChangeDateFormatInSesiunes < ActiveRecord::Migration
  def up
    change_column :sesiunes, :deadline, :date
  end

  def down
    change_column :sesiunes, :deadline, :datetime
  end
end
