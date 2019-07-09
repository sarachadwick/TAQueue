class AddCanvasDataToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :canvas_id, :numeric
    add_column :users, :course_id, :numeric
    add_column :users, :ta, :boolean
  end
end
