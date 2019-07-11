class AddLimitToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :limit, :integer
  end
end
