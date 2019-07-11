class AddsIdsAndEndTimeToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :ta_id, :string
    add_column :students, :student_id, :string
    add_column :students, :session_end, :datetime
  end
end
