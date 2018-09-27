# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Teacher.create(teacher_name: 'teacher_1')
Teacher.create(teacher_name: 'teacher_2')

Category.create(category_name: "category_1")
Category.create(category_name: "category_2")

CourseTeacher.create(course_id: 1, teacher_id: 1)
CourseTeacher.create(course_id: 2, teacher_id: 2)
Subcategory.create(subcategory_name: 's_name_1', category_id: 1)
Subcategory.create(subcategory_name: 's_name_2', category_id: 2)

Course.create(course_code: 'code1', course_name: 'name1', subcategory_id: 1)
Course.create(course_code: 'code2', course_name: 'name2', subcategory_id: 2)
