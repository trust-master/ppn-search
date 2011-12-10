# == Schema Information
#
# Table name: service_area_coverages
#
#  id              :integer         not null, primary key
#  company_id      :integer
#  service_area_id :integer
#  coverage_type   :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class ServiceAreaCoverage < ActiveRecord::Base
    belongs_to :company
    has_one :service_area
end
