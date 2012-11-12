class CompanyObserver < ActiveRecord::Observer

  def trigger(record)
    record.fetch
  end

end