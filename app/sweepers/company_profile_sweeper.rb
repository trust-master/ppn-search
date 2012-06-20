class CompanyProfileSweeper < ActiveRecord::Observer
  observe Discount, CompanyCategory, CompanyServiceArea, Location, Affiliation, Association, BusinessFiling, BusinessLicense, Certification, PersonalLicense

  def expire_cache_for(model)
    expire_fragment([:companies, model.company_id, :profile]) # the company's profile for search

    return true # to ensure that nothing is canceled here
  end

  alias :before_destroy :expire_cache_for
  alias :after_save     :expire_cache_for

  private :expire_cache_for

end