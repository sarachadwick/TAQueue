class AddCanvasDataToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :course_id, :number
  end
end
