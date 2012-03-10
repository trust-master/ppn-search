class AddFetchedTimeToScrapedModels < ActiveRecord::Migration
  def change
    %w[business_licenses personal_licenses business_filings].each do |table|
      add_column table, :fetched_at, :datetime
    end
  end
end
