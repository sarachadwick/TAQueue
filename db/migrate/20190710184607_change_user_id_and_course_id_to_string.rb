class ChangeUserIdAndCourseIdToString < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :course_id, :string
    change_column :users, :canvas_id, :string
    change_column :courses, :course_id, :string
  end

  def down
    change_column :users, :course_id, :decimal
    change_column :users, :canvas_id, :decimal
    change_column :courses, :course_id, :decimal
  end
end
