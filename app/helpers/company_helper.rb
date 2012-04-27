module CompanyHelper

  def service_areas_partial_only_collection
    { false => t('service_areas.partial_only.false'),
      true =>  t('service_areas.partial_only.true') }.to_a
  end

  def dom_class_for_search_result(company)
    dom_class = []
    dom_class << :inactive unless company.active && company.visible
  end

end

