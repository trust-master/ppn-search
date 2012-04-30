class Certification < ActiveRecord::Base
  belongs_to :company

  has_attached_file :attachment
  set_callback(:post_process, :before) do
    !! ValidationPatterns::ImageContentTypes.match(attachment.content_type)
  end

  validates_presence_of :name, :description
  validates_attachment :attachment,
    size: {
      less_than_or_equal_to: 1.megabytes },
    content_type: {
      content_type: ValidationPatterns::AcceptableUploadTypes }

  attr_accessible :name, :title, :description, :attachment, as: [:user, :company_admin, :administrator]
  attr_readonly :company_id # certifications shouldn't be moving around between companies

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
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

