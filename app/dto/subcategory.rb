class Subcategory
  def initialize(name, category)
    @subcategory_name = name
    @course_list = []
    @category = category
  end
  attr_accessor :subcategory_name, :course_list
end