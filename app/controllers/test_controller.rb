class TestController < ApplicationController

  require 'thinreports'

  def test
    respond_to do |format|
      format.html # show.html.erb
      format.pdf do

        # Thin ReportsでPDFを作成
        # 先ほどEditorで作ったtlfファイルを読み込む
        report = Thinreports::Report.new(layout: "#{Rails.root}/app/pdfs/course.tlf")

        # 1ページ目を開始
        report.start_new_page

        report.page.item(:number_0)
        report.page.item(:number_1)
        report.page.item(:number_2)
        report.page.item(:number_3)
        report.page.item(:number_4)
        report.page.item(:number_5)
        report.page.item(:number_6)
        report.page.item(:name)

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
