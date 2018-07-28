class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :course
      t.string :name
      t.string :reason
      t.boolean :being_helped

      t.timestamps
    end
  end
end
