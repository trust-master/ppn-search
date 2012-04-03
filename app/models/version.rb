::Version.class_eval do

  attr_accessible :ip_address, :published, :controller_name

end

# == Schema Information
#
# Table name: versions
#
#  id              :integer         not null, primary key
#  item_type       :string(255)     not null
#  item_id         :integer         not null
#  event           :string(255)     not null
#  whodunnit       :integer
#  object          :text
#  object_changes  :text
#  created_at      :datetime        not null
#  published       :boolean         not null
#  ip_address      :string(255)
#  controller_name :string(255)
#

