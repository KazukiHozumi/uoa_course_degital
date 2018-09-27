require_relative '../app/models/data_collector'

def createCategoryDB(category)
  Category.create(category_name: category.category_name)
  dummyCategory = Category.where(category_name: category.category_name).records[0]
  category.subcategories.each { |subcategory|
    createSubcategoryDB(dummyCategory.id, subcategory)
  }
end

def createSubcategoryDB(category_id, subcategory)
  Subcategory.create(subcategory_name: subcategory.subcategory_name, category_id: category_id)
  dummySubcategory = Subcategory.where(subcategory_name: subcategory.subcategory_name).records[0]
  subcategory.course_list.each { |course|
    createCourseDB(dummySubcategory.id, course)
  }
end

def createCourseDB(subcategory_id, course)
  Course.create(course_code: course.course_code, course_name: course.course_name, subcategory_id: subcategory_id)
  dummyCourse = Course.where(course_name: course.course_name).records[0]
  course.teachers.each { |teacher|
    if Teacher.where(teacher_name: teacher).records[0].nil?
      createTeacherDB(teacher)
    end
    dummyTeacher = Teacher.where(teacher_name: teacher).records[0]
    createCourse_teacherDB(dummyCourse.id, dummyTeacher.id)
  }
end

def createTeacherDB(teacher)
  Teacher.create(teacher_name: teacher)
end

def createCourse_teacherDB(course_id, teacher_id)
  CourseTeacher.create(course_id: course_id, teacher_id: teacher_id)
end

DataCollector.new.get_courses.each do |category|
  createCategoryDB category
end