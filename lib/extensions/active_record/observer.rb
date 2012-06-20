module ActiveRecord
  class Observer

    # Just delegate this to an new instance of app controller, so we can expire cache in the observer
    def expire_fragment(*args, &block)
      ApplicationController.new.expire_fragment(*args, &block)
    end
  end
end
