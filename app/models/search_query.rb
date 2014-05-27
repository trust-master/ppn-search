class SearchQuery
  extend ActiveModel::Naming

  attr_accessor :query, :category_ids

  def initialize(attributes = {})
    @query = attributes[:query]
    @category_ids = Array(attributes[:category_ids]).map(&:presence).compact
  end

  def companies
    scope = Company.scoped
    unless category_ids.empty?
      scope = scope.includes(:company_categories)
        .where('company_categories.sub_category_id' => category_ids)
    end
    if query
      matching_ids = CompanySearch.basic_search(query).map(&:company_id).uniq
      if matching_ids.any?
        scope = scope.where(id: matching_ids)
      else
        scope = scope.none
      end
    end
    scope
  end

  def to_key
    nil
  end

  def persisted?
    false
  end
end
