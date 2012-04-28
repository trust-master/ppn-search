class PageSweeper < ActionController::Caching::Sweeper
  observe Page

  def expire_cache_for(page)
    Rails.cache.delete([:page, page.slug]) # the cached page itself
    Rails.cache.delete(:page_meta_map) # the cached map for page names to titles and slugs
  end

  alias :after_create :expire_cache_for
  alias :after_update :expire_cache_for
  alias :after_destroy :expire_cache_for

  private :expire_cache_for

end