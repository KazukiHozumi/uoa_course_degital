class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :course_code
      t.string :course_name
      t.integer :subcategory_id

      t.timestamps
    end
  end
end
