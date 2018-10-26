class ScoreFileProcess
  require 'csv'
  def process_score_csv_file(csv_file)
    taking_courses = nil
    file_content = csv_file.read
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
    taking_courses = csv.drop_while do |row|
      !row[csv.headers[7]].nil?
    end
    taking_courses
  end

  # csvファイルを解析した結果を元にDBで検索
  def find_data(result)

  end
end
