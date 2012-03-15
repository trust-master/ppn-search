class Certification < ActiveRecord::Base
  belongs_to :company

  validates_presence_of :name

  attr_accessible :name, :title, :description, :certificate, :certificate_cache, :remove_certificate,
    as: [:default, :admin]
  attr_readonly :company_id

  mount_uploader :certificate, CertificateUploader
end


# == Schema Information
#
# Table name: certifications
#
#  id          :integer         not null, primary key
#  company_id  :integer
#  name        :string(255)
#  title       :string(255)
#  description :text
#  certificate :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

