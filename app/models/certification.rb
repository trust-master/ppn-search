# == Schema Information
#
# Table name: certifications
#
#  id                   :integer         not null, primary key
#  company_id           :integer
#  name                 :string(255)
#  title                :string(255)
#  certificate_filename :string(255)
#  description          :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class Certification < ActiveRecord::Base
    validates_presence_of :name
end
