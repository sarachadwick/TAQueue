class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :prefix
      t.string :course_code
      t.text :tas

      t.timestamps
    end
  end
end
