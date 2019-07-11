class ChangeCourseIdToString < ActiveRecord::Migration[5.1]
  def change
    change_column :students, :course_id, :string
  end
end
