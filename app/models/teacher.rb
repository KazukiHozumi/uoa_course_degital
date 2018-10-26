class Teacher < ApplicationRecord
  has_many :course_teachers
  has_many :courses, through: :course_teachers
end
