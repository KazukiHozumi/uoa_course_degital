class Subcategory
  def initialize(name, category_id)
    @subcategory_name = name
    @course_list = []
    @category_id = category_id
  end
  attr_accessor :subcategory_name, :course_list
end