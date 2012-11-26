# Just like CounterUpdater, but with the Throttle, so it can be scheduled easily
class Jobs::ScheduledCounterUpdater
  include ::Sidekiq::Worker
  sidekiq_options queue: :maintenance

  include Jobs::Throttle
  self.throttle_limit = 24.hours

  def perform(*)
    SubCategory.update_counter_values
  end

end