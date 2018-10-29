class ScoreFileProcess
  require 'csv'
  def find_taking_courses(csv_file)
    file_content = csv_file.read.force_encoding 'UTF-8'
    replaced_csv = file_content.delete "\r"
    csv = CSV.parse replaced_csv

    # 空文字やnilのみの行を削除し，必要な行のみを取得
    only_score_csv = csv.to_a.compact.delete_if do |row|
      row.all? do |cell|
        cell.nil? || cell == ''
      end
    end[5..-1]

    # 各要素をコンマ区切り，各行を改行区切りにする
    joined_only_score = only_score_csv.map { |array| array.join ',' }.join "\n"

    # CSV::Table
    csv = CSV.parse joined_only_score, headers: true

    # 履修中科目を取得
    taking_courses_csv = csv.drop_while do |row|
      !row[csv.headers[7]].nil?
    end

    course_name_list = taking_courses_csv.map { |course| course[csv.headers[4]] }

    taking_courses = Category.includes(subcategories: [courses: :teachers])
                         .where(courses: { course_name: course_name_list })
    taking_courses
  end
end
