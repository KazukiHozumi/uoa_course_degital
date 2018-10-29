class CourseController < ApplicationController
  def top
  end
  
  def list
    @student_id = params[:studentId]
    @name = params[:name]
    @score_file = params[:score_file]
    score_file = ScoreFileProcess.new
    categories = score_file.find_taking_courses @score_file
    @course_list = []
    categories.each do |category|
      category.subcategories.each do |subcategory|
        @course_list << subcategory.courses
      end
      @course_list.flatten!
    end
  end

  def detail

    @teacher = Teacher.all
    @course = Course.all

    @name = params[:name]
    @student_id = params[:studentId]
    @selected_courses = params[:selectedCourses]

  end

  def pdf
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do

        student_id = params[:studentId]
        name = params[:name]
        selected_courses = params[:selectedCourses]

        student_id_split = student_id.split(//)
        student_id_split_drop = student_id_split.drop(1)
        selected_courses_list = selected_courses.split(",")
        form_student_id = [:number_0, :number_1, :number_2, :number_3, :number_4, :number_5, :number_6]
        form_courses = [[:code_0, :course_name_0, :instructor_0, :reason_0],
                        [:code_1, :course_name_1, :instructor_1, :reason_1],
                        [:code_2, :course_name_2, :instructor_2, :reason_2]]


        report = Thinreports::Report.new layout: File.join(Rails.root, 'app', 'pdfs', 'course.tlf')


        report.start_new_page
        student_id_split_drop.zip(form_student_id) do |id, form|
          report.page.item(form).value(id)
        end
        report.page.item(:name).value(name)
        selected_courses_list.zip(form_courses) do |course, form|
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
