class AdminViewResolver < ::ActionView::FileSystemResolver

  def initialize
    super("app/views")
  end

  def find_templates(name, prefix, partial, details)
    super(name, prefix.gsub(%r[\Aadmin/], ''), partial, details)
  end

end
