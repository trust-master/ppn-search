class ScrapedModelDefaultsObserver < ActiveRecord::Observer
  observe :business_license, :personal_license, :business_filing

  def after_initialize(model)
    if model.new_record?
      model.issuing_state_id ||= Jobs::Scrapers::Minnesota.id
    end
  end

end