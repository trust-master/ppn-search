module CompaniesFilters
  class SetUpMarkets
    def self.filter(controller)
      # REFACTOR: !!
      # return unless controller.params[:section] == 'service' or controller.params[:section].nil?

      controller.markets = controller.company.company_service_areas.includes(service_area: :market).group_by(&:market)
      service_areas = ServiceArea.includes(:market)
      if ids = controller.markets.values.flatten.map(&:service_area_id).presence
        service_areas = service_areas.where('id NOT IN (?)', ids)
      end
      service_areas.each do |service_area|
        controller.markets[service_area.market] ||= []
        built = controller.company.company_service_areas.build
        built.service_area = service_area
        built.mark_for_destruction
        controller.markets[service_area.market] << built
      end
    end
  end

  class SetUpCategories
    def self.filter(controller)
      # return unless controller.params[:section] == 'service' or controller.params[:section].nil?

      controller.categories = controller.company.company_categories.includes(sub_category: :category).group_by(&:category)
      sub_categories = SubCategory.includes(:category)
      if ids = controller.categories.values.flatten.map(&:sub_category_id).presence
        sub_categories = sub_categories.where('id NOT IN (?)', ids)
      end
      sub_categories.each do |sub_category|
        controller.categories[sub_category.category] ||= []
        built = controller.company.company_categories.build
        built.sub_category = sub_category
        built.mark_for_destruction
        controller.categories[sub_category.category] << built
      end
    end
  end
end