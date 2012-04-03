module Fetchable

  def fetched?
    !! fetched_at
  end

  def fetch
    if klass = [Jobs::Scrapers, self.issuing_state.try(:name), self.class].join('::').safe_constantize
      return Resque.enqueue(klass, self.company_id, self.number)
    else
      return false
    end
  end

  def self.included(model)
    model.class_eval do
      scope :fetched, where('fetched_at IS NOT NULL')
    end
  end

end