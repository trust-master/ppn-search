# This class represents the composite DB view for doing full-text search accross all Company text-
# fields using Texticle http://tenderlove.github.com/texticle/
class CompanySearch < ActiveRecord::Base
  belongs_to :company
  belongs_to :searchable, polymorphic: true

  def self.new(query = nil, sub_category_id = nil, scope = Company.scoped)
    return scope if query.blank? and sub_category_id.blank?
    ids = []
    ids << self.search(query).pluck(:company_id) unless query.blank?
    ids << CompanyCategory.where(sub_category_id: sub_category_id).pluck(:company_id) unless sub_category_id.blank?

    if ids.many?
      ids = ids.first & ids.last # replace this with an iterator if you add more facets
    else
      ids = ids.first
    end

    return scope.where(id: ids.uniq)
  end

  # Search records are never modified
  def readonly?; true; end

  # Our view doesn't have primary keys, so we need
  # to be explicit about how to tell different search
  # results apart; without this, we can't use :include
  # to avoid n + 1 query problems
  def hash; [searchable_id, searchable_type].hash; end
  def eql?(result)
    searchable_id == result.searchable_id and searchable_type == result.searchable_type
  end
end
# == Schema Information
#
# Table name: company_searches
#
#  company_id                        :text
#  about                             :text
#  address                           :text
#  application_number                :text
#  chief_executive_officer           :text
#  city                              :text
#  description                       :text
#  doing_business_as                 :text
#  general_info                      :text
#  home_jurisdiction                 :text
#  name                              :text
#  number                            :text
#  phone_fax                         :text
#  phone_main                        :text
#  phone_mobile                      :text
#  phone_number                      :text
#  raw_data                          :text
#  registered_agents                 :text
#  registered_office_address         :text
#  responsible_person_license_number :text
#  title                             :text
#  url                               :text
#  website_url                       :text
#  searchable_type                   :string
#  searchable_id                     :integer
#

