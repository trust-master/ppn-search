class Jobs::Scrapers::Minnesota::AbstractDOLIScraper::LicenseData

  attr_reader :type
  def initialize(type)
    @type = type
    @hash = Hash.new
  end

  def address2=(address)
    @hash[:address2] = address.gsub(/([\s\w]+\w)\s*,\s*([A-Z]{2})\s*(\d{5}(?:-\d{4})?)/i) do |m|
      "#{$1.titlecase}, #{$2.upcase} #{$3}"
    end
  end

  def address
    [@hash[:address1], @hash[:address2]].compact.join("\n").presence
  end

  def enforcement_action=(val)
    @hash[:enforcement_action] = val == 'YES'
  end

  def ce_status=(val)
    @hash[:ce_status] = val.titlecase if val.is_a?(String)
  end

  def name=(val)
    @hash[:name] = val.titlecase if val.is_a?(String)
  end

  def lic_type=(val)
    raise SanityCheckFailedError unless val.is_a?(String)

    @hash[:type_id] = LicenseType.where(
      state_id: Jobs::Scrapers::Minnesota.id,
      name: val.titlecase,
      type: "#{type.to_s.titlecase}LicenseType"
    ).first_or_create!.id
  end

  def lic_status=(val)
    raise SanityCheckFailedError unless val.is_a?(String)

    @hash[:status_id] = LicenseStatus.where(name: val.titlecase).first_or_create!.id
  end

  def count
    @hash.count
  end

  def sanity_check!
    if count < 5
      raise SanityCheckFailedError
    end
  end

  def [](key)
    @hash[key]
  end

  def stringify_keys
    @hash.stringify_keys
  end

  def method_missing(name, *args, &block)
    case name
    when /\A(\w+)=\z/
      @hash[$1.to_sym] = args.first.presence
    when /\A(\w+)\?\z/
      !!@hash[$1]
    else
      @hash[name]
    end
  end

  def real_name
    split_name[0]
  end

  def doing_business_as
    split_name[1]
  end

  def split_name
    name.split(/\s+DBA\s+/i)
  end

end