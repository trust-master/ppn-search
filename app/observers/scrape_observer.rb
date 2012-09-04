class ScrapeObserver < ActiveRecord::Observer
  observe :business_license, :personal_license, :business_filing

  def after_create(record)
    record.fetch
  end

end