module Fetchable

  def fetched?
    !! fetched_at
  end

  def fetch
    if klass = scraper_class
      return klass.perform_async(self.company_id, self.number)
    else
      return false
    end
  end

  def self.included(model)
    model.class_eval do
      scope :fetched, -> { where('fetched_at IS NOT NULL') }
    end
  end

  def scraper_class
    [
      Jobs::Scrapers,
      self.issuing_state.name,
      "#{self.class.name}Scraper"
    ].join('::').safe_constantize
  rescue
    nil
  end

end
