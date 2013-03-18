require 'zeus/rails'

class ZeusCustomPlan < Zeus::Rails

  def worker
    require 'sidekiq/cli'

    begin
      cli = Sidekiq::CLI.instance
      cli.parse
      cli.run
    rescue => e
      raise e if $DEBUG
      STDERR.puts e.message
      STDERR.puts e.backtrace.join("\n")
      exit 1
    end
  end

  def test
    if defined?(RSpec)
      # disable autorun in case the user left it in spec_helper.rb
      RSpec::Core::Runner.disable_autorun!
      exit RSpec::Core::Runner.run(ARGV)
    else
      Zeus::M.run(ARGV)
    end
  end
end

Zeus.plan = ZeusCustomPlan.new
