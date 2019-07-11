class CreateSemesters < ActiveRecord::Migration[5.1]
  def change
    create_table :semesters do |t|
      t.integer :semester_length
      t.datetime :start_date
      t.string :course_id

      t.timestamps
    end
  end
end
