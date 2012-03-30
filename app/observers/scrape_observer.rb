class ScrapeObserver < ActiveRecord::Observer
  observe :company

  def after_save(company)
    company.business_licenses.all.each(&:fetch)
    company.personal_licenses.all.each(&:fetch)
    company.business_filings.all.each(&:fetch)
  end

end