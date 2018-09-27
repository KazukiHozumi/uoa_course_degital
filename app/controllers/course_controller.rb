class CourseController < ApplicationController
  def top
  end

  def list

    @teacher = Teacher.all
    @course = Course.all


  end

  def detail

    @teacher = Teacher.all
    @course = Course.all
  end

  def test
  end

end
