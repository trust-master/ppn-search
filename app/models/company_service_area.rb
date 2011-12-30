class CompanyServiceArea < ActiveRecord::Base
  belongs_to :company
  belongs_to :service_area
end

