class Location < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :company
  belongs_to_active_hash :state
  belongs_to_active_hash :country

  before_validation :infer_country_from_state

  validates :state, :country, associated: true
  validates :city, :state,    presence: true

  attr_accessible :street, :street2, :city, :state_id, :zip, :country_id, as: [:user, :company_admin, :administrator]
  attr_readonly :company_id

  delegate :name, :abbreviation, to: :state,   prefix: true
  delegate :name, :abbreviation, to: :country, prefix: true

  def name
    [city, state_abbreviation].compact.join(', ')
  end

  def to_s
    address = [street, street2, city, state_abbreviation].map(&:presence).compact.join(', ')
    address << ' ' << zip if zip.present?
    return address
  end

  private

    # to ensure that we retain integrity for this association (at least, when it's messed with the normal way)
    def infer_country_from_state
      if self.state_id
        self.country_id = self.state.country_id
      end
    end

end




# == Schema Information
#
# Table name: locations
#
#  id         :integer         not null, primary key
#  company_id :integer
#  city       :string(255)
#  state_id   :integer
#  zip        :string(255)
#  country_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  street     :string(255)
#  street2    :string(255)
#

