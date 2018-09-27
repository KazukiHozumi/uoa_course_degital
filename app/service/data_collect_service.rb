require 'nokogiri'
require 'open-uri'

require '../dto/category'
require '../dto/subcategory'
require '../dto/course'

class DataCollectService
  def get_courses

    syllabus_url = 'http://web-ext.u-aizu.ac.jp/official/curriculum/syllabus/1_J_000.html'

    html = open(syllabus_url, &:read)

    categorys = []

    doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')
    doc.xpath('//div[@class="box"]').each do |box|
      category = Category.new(box.css('td.daikbn').inner_text.strip)
      count = -1
      box.xpath('./div/table').children.each do |tr|
        table = tr.xpath('./td/table')[0]
        next if table.nil?
        if table.attributes['class'].value == 'chu-inner'
          count += 1
          category.subcategories << Subcategory.new(table.xpath('.//td[@class="chukbn"]').text.strip, category)
          next
        end
        if category.subcategories.empty?
          count += 1
          category.subcategories << Subcategory.new(category.category_name, category)
        end
        course_code, course_name = table.xpath('.//td[@class="kamoku"]/a').text.scan(/([^ ]+) (.+$)/)[0]
        category.subcategories[count].course_list << Course.new(course_code, course_name)
      end
      categorys << category
    end
  end
end

DataCollectService.new.get_courses