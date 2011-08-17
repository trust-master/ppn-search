class ServiceAreaCoverage < ActiveRecord::Base
    belongs_to :company
    has_one :service_area
end
