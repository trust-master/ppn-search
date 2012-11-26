class Jobs::Scheduler
  include ::Sidekiq::Worker
  sidekiq_options queue: :scheduler

  # include Jobs::Lock
  include Jobs::Throttle
  self.throttle_limit = 10.minutes.to_i - 3

  def perform(*args)
    [PersonalLicense, BusinessLicense, BusinessFiling].each do |model|
      model.outdated.all.each(&:fetch)
    end

    Jobs::ScheduledCounterUpdater.perform_async


    self.class.enqueue
  end

  # Enqueues itself to run next in 10 minutes, any scheduled runs in the next 11 minutes are removed
  def self.enqueue
    self.clear_schedule(11.minutes)
    self.perform_in(10.minutes)
  end

  def self.clear_schedule(int = 11.minutes)
    Sidekiq.redis do |r|
      scheduled = r.zrangebyscore('schedule', '-inf', int.from_now.to_f.to_s)
      scheduled.each do |msg|
        job = Sidekiq.load_json(msg)
        if job['class'] == self.name
          r.zrem('schedule', msg) # delete the scheduled run
        end
      end
    end
    return false
  end
end
