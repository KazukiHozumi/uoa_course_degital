class CategoryDTO
    def initialize(name)
      @category_name = name
      @subcategories = []
    end
    attr_accessor :category_name, :subcategories
end