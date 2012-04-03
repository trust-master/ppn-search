class CompanyServiceArea < ActiveRecord::Base
  belongs_to :company
  belongs_to :service_area, include: :market

  attr_accessible :service_area_id, :partial_only, as: [:user, :company_admin, :administrator]
  attr_readonly :company_id

  delegate :market, :market_id, to: :service_area
end



# == Schema Information
#
# Table name: company_service_areas
#
#  id              :integer         not null, primary key
#  company_id      :integer
#  service_area_id :integer
#  partial_only    :boolean         default(FALSE), not null
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

