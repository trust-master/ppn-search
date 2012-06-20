class CompanySweeper < ActiveRecord::Observer
  observe Company

  def expire_cache_for(model)
    expire_fragment([:companies, model.id, :profile]) # the company's profile for search

    return true
  end

  alias :before_destroy :expire_cache_for
  alias :after_save    :expire_cache_for

  private :expire_cache_for

end