class Country < ActiveYaml::Base
  set_root_path Rails.root.join('db')
  set_filename 'countries'

  include ActiveHash::Enum
  include ActiveHash::Associations

  enum_accessor :abbreviation

  has_many :states
  has_many :locations

end




# == Schema Information
#
# Table name: countries
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  abbreviation :string(255)     not null
#

