class SubcategoryDTO
  def initialize(name, category)
    @subcategory_name = name
    @course_list = []
    @category = category
    @detail_url = nil
  end
  attr_accessor :subcategory_name, :course_list, :detail_url
end