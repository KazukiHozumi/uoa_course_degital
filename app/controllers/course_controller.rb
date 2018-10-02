class CourseController < ApplicationController
  def top
  end

  def list

    @teacher = Teacher.all
    @course = Course.all
    @courseteacher = CourseTeacher.all
    @subcategory = Subcategory.all
    @studentId = params[:studentId]
    @name = params[:name]


  end

  def detail

    @teacher = Teacher.all
    @course = Course.all

    @name = params[:name]
    @studentId = params[:studentId]
    @selectedCourses = params[:selectedCourses]

  end

  def pdf
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do

        studentId = params[:studentId]
        name = params[:name]
        selectedCourses = params[:selectedCourses]

        studentId_split = studentId.split(//)
        studentId_split_drop = studentId_split.drop(1)
        selectedCourses_list = selectedCourses.split(",")
        form_studentId = [:number_0, :number_1, :number_2, :number_3, :number_4, :number_5, :number_6]
        form_courses = [[:code_0, :course_name_0, :instructor_0, :reason_0],
                        [:code_1, :course_name_1, :instructor_1, :reason_1],
                        [:code_2, :course_name_2, :instructor_2, :reason_2]]


        report = Thinreports::Report.new layout: File.join(Rails.root, 'app', 'pdfs', 'course.tlf')


        report.start_new_page
        form_studentId.zip(studentId_split_drop) do |form, id|
          report.page.item(form).value(id)
        end
        report.page.item(:name).value(name)
        selectedCourses_list.zip(form_courses) do |course, form|
          report.page.item(form[0]).value(course)
          report.page.item(form[1]).value('English')
          report.page.item(form[2]).value('hoge')
          report.page.item(form[3]).value('眠い')
        end

        send_data(
         report.generate,
         filename: 'course.pdf'
       )
       end
    end
  end

end
