module CompanyActivationRequirements
  def can_be_activated?
    CompanyActivationRequirements.criteria.all?{ |method| self.send(method) }
  end

  def activation_status
    status = CompanyActivationRequirements.criteria.map do |method|
      [method, self.send(method)]
    end
    Hash[status]
  end

  def self.criteria
    CompanyActivationRequirements.private_instance_methods(false).grep(/\Ahas\w+\?\z/)
  end

  private

  def has_name?
    name?
  end

  def has_in_business_since?
    in_business_since?
  end

  def has_email?
    email?
  end

  def has_at_least_one_phone_number?
    phone_main? or phone_mobile? or phone_fax?
  end

  def has_insurance?
    insured
  end

  def has_a_valid_business_filing?
    !! business_filing.try(:fetched?)
  end

end
