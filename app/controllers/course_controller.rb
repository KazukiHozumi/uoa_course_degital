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
    @selectedCoueses = params[:selectedCoueses]

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

        send_data(
         report.generate,
         filename: 'course.pdf'
       )
       end
    end
  end

end
