class PopularCategoriesSweeper < ActiveRecord::Observer
  observe CompanyCategory, Category, SubCategory

  def expire_cache_for(cc)
    expire_fragment(:popular_categories)

    return true
  end

  alias :before_destroy :expire_cache_for
  alias :after_save    :expire_cache_for

  private :expire_cache_for

end