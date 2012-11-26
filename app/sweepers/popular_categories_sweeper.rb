class PopularCategoriesSweeper < ActiveRecord::Observer
  observe Category, SubCategory, CompanyCategory

  def expire_cache_for(_)
    expire_fragment(:popular_categories)
    return true
  end

  alias :before_destroy    :expire_cache_for
  alias :after_save        :expire_cache_for

  private :expire_cache_for

end