
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
    if Teather.find(teacher_name: teacher) == nil
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

require 'nokogiri'
require 'open-uri'

class Category2
  def initialize(name)
    @category_name = name
    @subcategories = []
  end
  attr_accessor :category_name, :subcategories
end

class Course2
  def initialize(code, name)
    @course_code = code
    @course_name = name
    @teachers = []
    @subcourse_id = nil
  end

  attr_accessor :course_code, :course_name, :teachers
end

class Subcategory2
  def initialize(name, category)
    @subcategory_name = name
    @course_list = []
    @category = category
  end
  attr_accessor :subcategory_name, :course_list
end

class DataCollectService2
  def get_courses

    syllabus_url = 'http://web-ext.u-aizu.ac.jp/official/curriculum/syllabus/1_J_000.html'

    html = open(syllabus_url, &:read)

    categorys = []

    doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')
    doc.xpath('//div[@class="box"]').each do |box|
      category = Category2.new(box.css('td.daikbn').inner_text.strip)
      count = -1
      box.xpath('./div/table').children.each do |tr|
        table = tr.xpath('./td/table')[0]
        next if table.nil?
        if table.attributes['class'].value == 'chu-inner'
          count += 1
          category.subcategories << Subcategory2.new(table.xpath('.//td[@class="chukbn"]').text.strip, category)
          next
        end
        if category.subcategories.empty?
          count += 1
          category.subcategories << Subcategory2.new(category.category_name, category)
        end
        course_code, course_name = table.xpath('.//td[@class="kamoku"]/a').text.scan(/([^ ]+) (.+$)/)[0]
        category.subcategories[count].course_list << Course2.new(course_code, course_name)
      end
      categorys << category
    end
    categorys
  end
end

DataCollectService2.new.get_courses.each { |category|
  createCategoryDB(category)
}
