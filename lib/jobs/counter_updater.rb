class Jobs::CounterUpdater
  include ::Sidekiq::Worker
  sidekiq_options queue: :maintenance

  include Jobs::Lock

  def perform(*)
    SubCategory.update_counter_values
  end

end