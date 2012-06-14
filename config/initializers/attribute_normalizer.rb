# config/initializers/attribute_normalizer.rb
AttributeNormalizer.configure do |config|

  config.normalizers[:phone_number] = lambda do |value, options|
    value.is_a?(String) ? value.gsub(/[^\dx]+/, '') : value
  end

  # config.normalizers[:truncate] = lambda do |text, options|
  #   if text.is_a?(String)
  #     options.reverse_merge!(:length => 30, :omission => "...")
  #     l = options[:length] - options[:omission].mb_chars.length
  #     chars = text.mb_chars
  #     (chars.length > options[:length] ? chars[0...l] + options[:omission] : text).to_s
  #   else
  #     text
  #   end
  # end

  config.normalizers[:squish_by_line] = proc { |v, options={}|
    v.is_a?(String) ? v.strip.gsub(/[ \t\r]*\n[ \t\r]*/,"\n") : v
  }

  # The default normalizers if no :with option or block is given is to apply the :strip and :blank
  # normalizers (in that order). You can change this if you would like as follows:
  config.default_normalizers = :strip, :squish_by_line, :blank

  # You can enable the attribute normalizers automatically if the specified attributes exist in your
  # column_names. It will use the default normalizers for each attribute (e.g. config.default_normalizers)
  config.default_attributes = :name, :title, :display_name, :email

  # Also, You can add an specific attribute to default_attributes using one or more normalizers:
  # config.add_default_attribute :name, :with => :truncate
end