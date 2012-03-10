module Fetchable

  def fetched?
    !! fetched_at
  end

  def fetch
    klass = [Jobs::Scrapers, self.issuing_state.name, self.class].join('::').constantize
    return Resque.enqueue(klass, self.company_id, self.number)
  # rescue NameError => e
  #   logger.error "#{self.class.name}#fetch was called when issuing_state=#{self.issuing_state.name.inspect}, which led to an error: #{e.message} (in #{__FILE__})"
  #   return false
  end

  def self.included(model)
    model.class_eval do
      scope :fetched, where('fetched_at IS NOT NULL')
    end
  end

end