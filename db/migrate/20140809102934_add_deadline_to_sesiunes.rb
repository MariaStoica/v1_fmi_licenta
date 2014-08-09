class AddDeadlineToSesiunes < ActiveRecord::Migration
  def change
    add_column :sesiunes, :deadline, :datetime
  end
end
