class Page < ActiveRecord::Base
  has_paper_trail

  PARSER = Redcarpet::Markdown.new(Renderers::Page.new)

  attr_readonly :name
  attr_accessible :name, :slug, :title, :content, :published, as: :administrator

  validates :name, :slug, :title,  length: { maximum: 255 }, presence: true
  validates :content, presence: true
  validates :name, uniqueness: true, format: {with: /\A[a-z]\w+\Z/i}
  validates :slug, uniqueness: true, format: {with: %r[\A[a-z_$@.&+\-!*"'(),]+(/[a-z_$@.&+\-!*"'(),]+)*\Z]i}

  def render_content
    PARSER.render(self[:content]).html_safe
  end

  def path
    '/' << self[:slug]
  end

  class << self
    def meta_map
      Rails.cache.fetch(:page_meta_map) do
        HashWithIndifferentAccess.new.tap do |h|
          Page.select([:name, :title, :slug]).all.each do |page|
            h[page.name] = {title: page.title, slug: page.slug}
          end
        end
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

