require 'nokogiri'
require 'open-uri'

require '../dto/category'
require '../dto/subcategory'

class DataCollectService
  def get_courses

    syllabus_url = 'http://web-ext.u-aizu.ac.jp/official/curriculum/syllabus/1_J_000.html'

    html = open(syllabus_url, &:read)

    categorys = []

    doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')
    doc.xpath('//div[@class="box"]').each do |box|
      category = Category.new(box.css('td.daikbn').inner_text.strip)
      count = 0
      box.xpath('./div//tr').each do |tr|
        if tr.xpath('.//table[@class="chu-inner"]')

        end
      end
      categorys << category
    end

    categorys.each do |category|
      p category.category_name
      p category.subcategories
    end

  end
end

DataCollectService.new.get_courses