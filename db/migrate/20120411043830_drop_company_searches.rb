class DropCompanySearches < ActiveRecord::Migration
  def change
    say_with_time 'Dropping possible existing company_searches view...' do
      execute "DROP VIEW company_searches"
    end
  end
end