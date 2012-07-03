# This class represents the composite DB view for doing full-text search accross all Company text-
# fields using Texticle http://tenderlove.github.com/texticle/
class CompanySearch < ActiveRecord::Base
  belongs_to :company
  belongs_to :searchable, polymorphic: true

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
#  benefits                          :text
#  chief_executive_officer           :text
#  city                              :text
#  description                       :text
#  doing_business_as                 :text
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
#  specialty                         :text
#  street                            :text
#  street2                           :text
#  title                             :text
#  url                               :text
#  website_url                       :text
#  searchable_type                   :string
#  searchable_id                     :integer
#

