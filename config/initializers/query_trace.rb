# This outputs the location of the code that initiated any SQL query, in the logs
if Rails.env.development? or Rails.env.test?
  module QueryTrace
    def self.append_features(klass)
      super
      klass.class_eval do
        unless method_defined?(:log_info_without_trace)
          alias_method :log_info_without_trace, :sql
          alias_method :sql, :log_info_with_trace
        end
      end
    end

    def log_info_with_trace(event)
      log_info_without_trace(event)

      return if event.payload[:name] == 'SCHEMA'

      trace = clean_trace(caller)[0,1]
      trace = trace.map { |l| l.gsub(/in \`?_\w+_haml_\w+/, 'in <haml_template>')}
      if trace.any? and trace.grep(%r[app/admin]).none?
        logger.debug("    \e[1m\e[31mCalled from:\e[0m - %s" % [trace.join("\n                 - ")])
      end
    end

    def clean_trace(trace)
      Rails.respond_to?(:backtrace_cleaner) ? Rails.backtrace_cleaner.clean(trace) : trace
    end
  end

  class ::ActiveRecord::LogSubscriber
    include QueryTrace
  end
end
