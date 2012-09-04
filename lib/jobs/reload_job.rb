class Jobs::ReloadJob
  include Sidekiq::Worker
  sidekiq_options queue: :debug

  def perform(print = true, *args)
    puts "Reloading..." if print
    ActionDispatch::Reloader.cleanup!
    ActionDispatch::Reloader.prepare!
    true
  end


end