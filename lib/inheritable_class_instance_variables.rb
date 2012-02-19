module InheritableClassInstanceVariables
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def inheritable_class_instance_variables(*args)
      @inheritable_class_instance_variables ||= [:inheritable_class_instance_variables]
      @inheritable_class_instance_variables += args
      # args.each do |arg|
      #   class_eval %(
      #     class << self; attr_accessor :#{arg} end
      #   )
      # end
      @inheritable_class_instance_variables
    end

    def inherited(subclass)
      @inheritable_class_instance_variables.each do |inheritable_class_instance_variable|
        instance_var = "@#{inheritable_class_instance_variable}"
        subclass.instance_variable_set(instance_var, instance_variable_get(instance_var))
      end
    end
  end
end