class CreateCompanySearches < ActiveRecord::Migration
  def self.up
    say_with_time 'Creating company_searches view...' do
      tables = [Company, PersonalLicense, BusinessLicense, BusinessFiling, Affiliation, Association,
        Certification, Location, Discount]
      @columns = tables.map{ |model|
        cols = model.columns.map{|c|
          c.name if [:text, :string].include?(c.type)
        }
        cols = cols - model.uploaders.keys.map(&:to_s)
      }
      @columns = @columns.flatten.compact.uniq.sort

      # columns not to include in search
      @columns.delete('continuing_education')
      @columns.delete('zip')
      @columns.delete('email')
      @columns.delete('admin_email')

      sql = tables.map { |model|

        id_column = model.column_names.include?('company_id') ? 'company_id' : 'id'
        uploader_columns = model.uploaders.keys.map(&:to_s)

        cols_sql = [id_column, *@columns].map {|c|
          as_name = c == id_column ? 'company_id' : c
          if c = model.columns_hash[c] and !uploader_columns.include?(c) and
              c.name == id_column || [:text, :string].include?(c.type) then

            selector = "CAST(#{[model.table_name, c.name].join('.')} AS text)"
          else
            selector = 'NULL'
          end
          [selector, as_name].join(' AS ')
        }
        cols_sql << "CAST('#{model.name}' AS varchar) AS searchable_type"
        cols_sql << "#{model.table_name}.id AS searchable_id"

        "SELECT #{cols_sql.compact.join(', ')} FROM #{model.table_name}"
      }.join(" UNION ")


      execute "CREATE VIEW company_searches AS #{sql}"
    end
  end
  def self.down
    say_with_time 'Dropping company_searches view...' do
      execute "DROP VIEW company_searches"
    end
  end
end

