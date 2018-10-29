require 'nokogiri'
require 'open-uri'
require 'mechanize'

require_relative '' '../../lib/category_dto'
require_relative '' '../../lib/course_dto'
require_relative '' '../../lib/subcategory_dto'

class DataCollector
  def get_courses

    syllabus_url = 'http://web-ext.u-aizu.ac.jp/official/curriculum/syllabus/1_J_000.html'

    html = open(syllabus_url, &:read)

    categories = []

    doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')
    doc.xpath('//div[@class="box"]').each do |box|
      category = CategoryDTO.new(box.css('td.daikbn').inner_text.strip)
      count = -1
      box.xpath('./div/table').children.each do |tr|
        table = tr.xpath('./td/table')[0]
        next if table.nil?
        if table.attributes['class'].value == 'chu-inner'
          count += 1
          category.subcategories << SubcategoryDTO.new(table.xpath('.//td[@class="chukbn"]').text.strip,
                                                       category)
          next
        end
        if category.subcategories.empty?
          count += 1
          category.subcategories << SubcategoryDTO.new(category.category_name,
                                                       category)
        end
        kamoku = table.xpath('.//td[@class="kamoku"]/a')
        course_code, course_name = kamoku.text.scan(/([^ ]+) (.+$)/)[0]
        category.subcategories[count].course_list << CourseDTO.new(course_code,
                                                                   course_name)
        relative_detail_url = kamoku[0].attributes['href'].value
        category.subcategories[count].detail_url = 'http://web-ext.u-aizu.ac.jp/official/curriculum/syllabus/'
        + relative_detail_url
      end
      categories << category
    end

    categories.each do |category|
      category.subcategories.each do |subcategory|
        html = open(subcategory.detail_url, &:read)
        doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')
        subcategory.course_list.each do |course|
          xpath_str = "//div[@id=\"#{course.course_code}
                        \"]//table[@class=\"syllabus-normal\"]"
          doc.xpath(xpath_str)[0].children.each do |tr|
            if tr.xpath('./th').text.include? '担当教員名'
              course.teachers = tr.xpath('./td').text.split(',').map(&:strip)
            end
          end
        end
      end
    end
    categories
  end
end
