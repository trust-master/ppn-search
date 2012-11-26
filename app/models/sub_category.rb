# == Schema Information
#
# Table name: sub_categories
#
#  id              :integer          not null, primary key
#  category_id     :integer
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  sort_order      :integer          default(0), not null
#  companies_count :integer          default(0), not null
#

class SubCategory < ActiveRecord::Base
  # default_scope order('sub_categories.sort_order DESC', :id)

  belongs_to :category, inverse_of: :sub_categories
  has_many :company_categories, dependent: :destroy
  has_many :companies,          through: :company_categories

  attr_accessible :name, :category_id, :sort_order, as: :administrator

  delegate :name, to: :category, prefix: true # will produce category_name method

  validates :name, length: { maximum: 255 }, presence: true
  validates_presence_of :category, :sort_order


  def self.counter_counts
    rel = self.scoped

    # Check that there is no where clause for company_id, if there is, convert it to something usable
    # if company_id = rel.where_values_hash.has_key?('company_id')
    #   sub_ids = connection.select_values(rel.select(:sub_category_id).to_sql)
    #   rel.where_values.reject! { |w| w.left.name == 'company_id' }
    #   rel = rel.where(sub_category_id: sub_ids)
    # end

    # Build a starter hash with all zeroes
    sql = rel.select([ :category_id, :id ]).to_sql
    counts = Hash.new
    connection.select_rows(sql, 'SQL').each do |r|
      counts[r[0]] ||= {}
      counts[r[0]][r[1]] = 0
    end

    rel = rel.select([ :category_id, :id, %q[COUNT(companies.id) AS company_count] ]).
      joins(:companies).
      where('companies.active = ?', true).
      where('companies.visible = ?', true).
      group(:category_id, :id)

    connection.select_all(rel.to_sql, 'SQL').each do |row|
      category_id, id, count = row.values_at('category_id','id','company_count')
      counts[category_id][id] = count.to_i
    end
    counts
  end

  def self.update_counter_values
    counter_counts.each do |category_id, sub_categories|
      sub_categories.each do |sub_category_id, count|
        SubCategory.where(id: sub_category_id).update_all(companies_count: count)
      end
      Category.where(id: category_id).update_all(companies_count: sub_categories.values.sum)
    end

    # HACK: Figure out a better way
    ActionController::Base.new.expire_fragment(:popular_categories)

    return nil
  end

end




