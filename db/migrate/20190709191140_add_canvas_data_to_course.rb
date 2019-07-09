class AddCanvasDataToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :course_id, :number
  end
end
