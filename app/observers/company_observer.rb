class CompanyObserver < ActiveRecord::Observer

  def trigger(company)
    if (company.changed & %w{ visible active }).any?
      Jobs::CounterUpdater.perform_async # Update category counts
    end
  end
  alias_method :after_save, :trigger

end