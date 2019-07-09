class AddTimeDataToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :helped_at, :datetime
  end
end
