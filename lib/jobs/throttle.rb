module Jobs::Throttle

  module ClassMethods

    # redefine this to customize it's behaviour
    def identifier(*args)
      Digest::MD5.hexdigest(args.map(&:to_s).join("\0"))
    end

    def throttled?(*args)
      !! Sidekiq.redis { |r| r.get(key(*args)) }
    end

    def key(*args)
      [:throttlers, self.name.underscore, identifier(*args)].join(?:)
    end

    def set_throttler(*args)
      Sidekiq.redis do |redis|
        if redis.respond_to?(:setex)
          redis.setex(key(*args), self.throttle_limit, true)
        else
          redis.set(key(*args), true, self.throttle_limit)
        end
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      cattr_accessor :throttle_limit # the minimum interval between runs of this job (with the same arguments)
      self.throttle_limit ||= 1.minute

      # Set up the alias chain, or set a callback to do so once the perform instance method is defined
      if method_defined? :perform
        alias_method_chain :perform, :throttle
      else
        def self.method_added(name)
          super
          return unless name == :perform
          alias_method_chain :perform, :throttle unless method_defined?(:perform_without_throttle)
        end
      end
    end
  end

  def perform_with_throttle(*args)
    if self.class.throttled?(*args)
      logger.debug "Job with identifier:(#{identifier(*args)}) was throttled!"

    else
      perform_without_throttle(*args)
      self.class.set_throttler(*args)
    end
  end

  def identifier(*args)
    self.class.identifier(*args)
  end

end