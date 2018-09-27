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

def createCategoryDB(category)
  Category.create(category_name: category.category_name)
  dummyCategory = Category.find(category_name: category.category_name)
  category.subcategories.each { |subcategory|
    CreateSubcategoryDB(dummyCategory.id, subcategory)
  }
end

def createSubcategoryDB(category_id, subcategory)
  Subcategory.create(subcategory.subcategory_name, category_id)
  dummySubcategory = Subcategory.find(subcategory_name: subcategory.subcategory_name)
  subcategory.course_list.each { |course|
    CreateCourseDB(dummySubcategory.id, course)
  }
end

def createCourseDB(subcategory_id, course)
  Course.create(course_code: course.course_code, course_name: course.course_name, subcategory_id: subcategory_id)
  dummyCourse = Course.find(course_name: course.course_name)
  course.teachers.each { |teacher|
    if Teather.find(teacher_name: teacher) == nil then
      createTeacherDB(teacher)
    end
    dummyTeacher = Teacher.find(teacher_name: teacher.teacher_name)
    createCourse_teacherDB(course_id: dummyCourse.id, teacher_id: dummyTeacher.id)
  }
end

def createTeacherDB(teacher)
  Teacher.create(teacher_name: teacher)
end

def createCourse_teacherDB(course_id, teacher_id)
  CourseTeacher.create(course_id: course_id, teacher_id: teacher_id)
end
