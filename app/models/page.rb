class Page < ActiveRecord::Base
  has_paper_trail


end

# == Schema Information
#
# Table name: pages
#
#  id        :integer         not null, primary key
#  name      :string(255)
#  slug      :string(255)
#  title     :string(255)
#  content   :text
#  published :boolean         default(FALSE), not null
#

