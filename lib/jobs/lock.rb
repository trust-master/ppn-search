module Jobs::Lock
  LockedJobError = Class.new(StandardError)

  module ClassMethods

    # redefine this to customize it's behaviour
    def identifier(*args)
      Digest::MD5.hexdigest(args.map(&:to_s).join("\0"))
    end

    def locked?(*args)
      !! Sidekiq.redis { |r| r.get(key(*args)) }
    end

    def key(*args)
      [:locks, self.name.underscore, identifier(*args)].join(?:)
    end

    def set_lock(*args)
      Sidekiq.redis do |redis|
        if redis.respond_to?(:setex)
          redis.setex(key(*args), 1.day, true)
        else
          redis.set(key(*args), true, 1.day)
        end
      end
    end
    def release_lock(*args)
      Sidekiq.redis do |redis|
        redis.del(key(*args))
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do

      # Set up the alias chain, or set a callback to do so once the perform instance method is defined
      if method_defined? :perform
        alias_method_chain :perform, :lock
      else
        def self.method_added(name)
          super
          return unless name == :perform
          alias_method_chain :perform, :lock unless method_defined?(:perform_without_lock)
        end
      end
    end
  end

  def perform_with_lock(*args)
    if self.class.locked?(*args)
      raise LockedJobError, "Job with args:#{args.inspect} was locked!"

    else
      begin
        self.class.set_lock(*args)
        perform_without_lock(*args)
      ensure
        self.class.release_lock(*args)
      end
    end
  end

  def identifier(*args)
    self.class.identifier(*args)
  end

end