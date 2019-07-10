class AddWeeklyHoursToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :weekly_hours, :integer
  end
end
