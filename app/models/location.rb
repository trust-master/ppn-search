class Location < ActiveRecord::Base
  belongs_to :company
  belongs_to :state
  belongs_to :country

  before_validation :infer_country_from_state

  validates :state, :country, associated: true
  validates :city, :state,    presence: true

  attr_accessible :street, :street2, :city, :state_id, :zip, :country_id, as: [:default, :admin]
  attr_readonly :company_id

  delegate :name, :abbreviation, to: :state, prefix: true
  delegate :name, :abbreviation, to: :country, prefix: true

  private

    # to ensure that we retain integrity for this association (at least, when it's messed with the normal way)
    def infer_country_from_state
      if self.state_id
        self.country_id = State.where(id: self.state_id).pluck(:country_id).first
      end
    end

    def name
      [city, state_abbreviation].compact.join(', ')
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
#  created_at :datetime
#  updated_at :datetime
#  street     :string(255)
#  street2    :string(255)
#

