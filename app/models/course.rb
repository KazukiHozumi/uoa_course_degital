class Course
  def initialize(code, name)
    @course_code = code
    @course_name = name
    @teachers = []
    @subcourse_id = nil
  end

  attr_accessor :course_code, :course_name, :teachers
end