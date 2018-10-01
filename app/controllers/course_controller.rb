class CourseController < ApplicationController
  def top
  end

  def list

    @teacher = Teacher.all
    @course = Course.all
    @courseteacher = CourseTeacher.all
    @subcategory = Subcategory.all


  end

  def detail

    @teacher = Teacher.all
    @course = Course.all
  end

  def pdf
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do

        # Thin ReportsでPDFを作成
        # 先ほどEditorで作ったtlfファイルを読み込む
        #report = Thinreports::Report.new(layout: "#{Rails.root}/app/pdfs/course.tlf")
        #report = Thinreports::Report.new
        #report.use_layout "#{Rails.root}/app/pdfs/course.tlf"
        report = Thinreports::Report.new layout: File.join(Rails.root, 'app', 'pdfs', 'course.tlf')

        studentId = params[:studentId]
        name = params[:name]

        # 1ページ目を開始
        report.start_new_page
        report.page.item(:number_0).value(0)
        report.page.item(:number_1).value(1)
        report.page.item(:number_2).value(2)
        report.page.item(:number_3).value(3)
        report.page.item(:number_4).value(4)
        report.page.item(:number_5).value(5)
        report.page.item(:number_6).value(6)
        report.page.item(:name).value(name)

        # ブラウザでPDFを表示する
        # disposition: "inline" によりダウンロードではなく表示させている
        send_data(
         report.generate,
         filename: 'course.pdf'
       )
       end

    end
  end

end
