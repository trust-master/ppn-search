class Page < ActiveRecord::Base
  has_paper_trail

  PARSER = Redcarpet::Markdown.new(Renderers::Page.new)

  attr_readonly :name
  attr_accessible :name, :slug, :title, :content, :published, as: :administrator

  validates :title, :content, presence: true
  validates :name, uniqueness: true, presence: true, format: {with: /\A[a-z]\w+\Z/i}
  validates :slug, uniqueness: true, presence: true, format: {with: %r[\A[a-z_$@.&+\-!*"'(),]+(/[a-z_$@.&+\-!*"'(),]+)*\Z]i}

  def render_content
    PARSER.render(self[:content]).html_safe
  end

  def path
    '/' << self[:slug]
  end

  class << self
    def slug_map
      Rails.cache.fetch(:page_paths) do
        h = Page.select([:name, :slug]).all.map { |p|
          [p.name.to_sym, p.slug]
        }
        HashWithIndifferentAccess.new(Hash[h])
      end
    end
  end
end


# == Schema Information
#
# Table name: pages
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  slug             :string(255)
#  title            :string(255)
#  content          :text
#  published        :boolean         default(FALSE), not null
#  created_at       :datetime
#  updated_at       :datetime
#  rendered_content :text
#

