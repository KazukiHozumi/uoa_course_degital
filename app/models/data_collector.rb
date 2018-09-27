require 'nokogiri'
require 'open-uri'

require './category'

class DataCollector
  def get_courses

    syllabus_url = 'http://web-ext.u-aizu.ac.jp/official/curriculum/syllabus/1_J_000.html'

    html = open(syllabus_url, &:read)

    categorys = []

    doc = Nokogiri::HTML.parse(html, nil, 'UTF-8')
    doc.xpath('//div[@class="box"]').each do |box|
      category = Category.new(box.css('td.daikbn').inner_text.strip)
      p chukbn = box.xpath('//td[@class="chukbn"]')[0].inner_text.strip
      categorys << category
    end

    categorys.each do |category|
      p category.category_name
    end

  end
end

DataCollector.new.get_courses