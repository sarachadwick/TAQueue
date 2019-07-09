class AddTimeDataToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :weekly_time, :integer # time in seconds
    add_column :users, :clocked_in_time, :datetime
  end
end
