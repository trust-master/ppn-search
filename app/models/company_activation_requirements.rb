module CompanyActivationRequirements
  def can_be_activated?
    activation_status.values.all?
  end

  def activation_status
    status = CompanyActivationRequirements.criteria.map do |method|
      [method, self.send(method)]
    end
    Hash[status]
  end

  def self.criteria
    CompanyActivationRequirements.private_instance_methods(false)
  end

  private

  def is_valid?
    valid?
  end

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
    insured and errors.keys.grep(/\Ainsurance_/).none?
  end

  def has_a_valid_business_filing?
    b = business_filing.tap{|v| p v} and
    b.fetched?.tap{|v| p v} and
    (b.status == FilingStatus.where(name: 'Active / In Good Standing').first!).tap{|v| p v} and
    (b.renewal_due_on + 7 >= Date.today).tap{|v| p v}
  end
end
