class CourseController < ApplicationController
  def top
  end

  def list

    @teacher = Teacher.all
    @course = Course.all
    @course_teacher = CourseTeacher.all
    @subcategory = Subcategory.all
    @student_id = params[:studentId]
    @name = params[:name]


  end

  # パラメータ付きで実装する(中間テーブルID。できればPOSTがいい)
  def detail

    @teacher = Teacher.all
    @course = Course.all

    @name = params[:name]
    @student_id = params[:studentId]
    @selected_courses = params[:selectedCoueses]

  end

  def pdf
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do

        sID = params[:studentId]

        report = Thinreports::Report.new layout: File.join(Rails.root, 'app', 'pdfs', 'course.tlf')

        numbers = [:number_0, :number_1, :number_2, :number_3, :number_4, :number_5, :number_6]
        sidslice = sID.split(//)
        sidslice = sidslice.drop(1)

        report.start_new_page
        numbers.zip(sidslice) do |num, siddigit|
          report.page.item(num).value(siddigit)
        end
        report.page.item(:name).value(params[:name])
        report.page.item(:code_0).value(3)
        report.page.item(:course_name_0).value('English')
        report.page.item(:instructor_0).value('hoge')
        report.page.item(:reason_0).value('眠い')
        report.page.item(:code_1).value(33)
        report.page.item(:course_name_1).value('math')
        report.page.item(:instructor_1).value('fuga')
        report.page.item(:reason_1).value('疲れた')
        report.page.item(:code_2).value(333)
        report.page.item(:course_name_2).value('programming')
        report.page.item(:instructor_2).value('guga')
        report.page.item(:reason_2).value('お酒飲みたい')
        

        send_data(
         report.generate,
         filename: 'course.pdf'
       )
       end
    end
  end

end
