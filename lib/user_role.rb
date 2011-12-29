class UserRole < ActiveSupport::StringInquirer
  def method_missing(method_name, *arguments)
    if method_name.to_s[-1,1] == "?"
      self == method_name.to_s[0..-2].classify
    else
      super
    end
  end
end