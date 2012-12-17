class CompanyObserver < ActiveRecord::Observer

  def after_save(company)
    if (company.changed & %w{ visible active }).any?
      Jobs::CounterUpdater.perform_async # Update category counts
    end
  end

end