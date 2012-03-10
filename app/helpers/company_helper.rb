module CompanyHelper
  def service_areas_partial_only_collection
    { false => t('service_areas.partial_only.false'),
      true =>  t('service_areas.partial_only.true') }.to_a
  end
end

