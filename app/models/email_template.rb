# == Schema Information
#
# Table name: email_templates
#
#  id           :string(255)      not null, primary key
#  display_name :string(255)
#  headers      :text
#  body         :text
#  template     :binary
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# This is the email version of the Page model. It's part of an interface to edit email templates through the Admin UI, which is incomplete

class EmailTemplate < ActiveRecord::Base
  has_paper_trail

  normalize_attribute :body, with: [:squish_by_line]
  normalize_attributes :display_name, :subject, :from, :bcc, :cc

  ### Validation
  validates_presence_of :body
  validates :from, :cc, :bcc, email: true, allow_blank: true
  validates :display_name, length: { maximum: 255 }, allow_blank: true

  ### Serialization
  serialize :headers, Hash
  # serialize :template, Mustache

  ### Callbacks

  # Puts the parse error from Liquid on the error list if parsing failed
  after_validation do
    errors.add :body, @syntax_error unless @syntax_error.nil?
  end

  # parse the template, only if needed, before saving
  before_save :template
  before_create :template

  ### Attributes
  attr_accessible :display_name, :headers, :body, as: :admin

  # set up accessors for each of the header fields from Mail. (the union is to influence sort order)
  HEADER_ATTRIBUTES = [:subject, :cc, :bcc, :from] | Mail::Field::KNOWN_FIELDS.map{|f| f.underscore.to_sym }
  HEADER_ATTRIBUTES.each do |field|
    define_method field do
      self[:headers][field]
    end
    define_method "#{field}=" do |value|
      self[:headers][field] = value
    end
  end

  MD_PARSER = Redcarpet::Markdown.new(Renderers::Email.new)

  # Renders the Liquid::Template with the given context hash, then
  # parses the returned markdown into HTML, and runs it through Premailer.
  #
  # returns the Premailer object, so call #to_inline_css or #to_plain_text on it
  def render(options = {})
    rendered_markdown = template.render(options.stringify_keys)

    html = MD_PARSER.render(rendered_markdown)

    Premailer.new html, # FIXME: Include some CSS, here
                  with_html_string: true,
                  base_url: Rails.application.config.action_mailer.default_url_options[:host]
  end

  def render_preview
    render(name: 'Name', link: 'http://example.com/eaeteha8oeo').to_inline_css.html_safe
  end

  def template
    return false if self[:body].nil?
    if @template.nil?
      if self[:template].nil?
        # not Marshalled in DB, parse
        return parse_template
      else
        begin
          # try to load the Marshalled object
          # @template = Marshal.load(Base64.decode64(self[:template]))
          @template = Marshal.load(self[:template])
        rescue Exception => ex
          # it failed, so parse
          logger.error "ERROR: Unmarshalling EmailTemplate failed! #{ex.inspect}"
          return parse_template
        end
      end
    end
    # don't let the parsed/cached template get stale
    parse_template unless @template.instance_variable_get(:@source) == self[:body]

    return @template
  end

  private

  # instantiate a new Liquid::Template object, which is serialized for later use.
  def parse_template
    @template = Liquid::Template.parse(self[:body]).tap do |liquid_template|
      # this will be used to see if the body has changed
      liquid_template.instance_variable_set(:@source, self[:body])

      # marshal to DB, encode as Base64 to avoid issues with DB escaping (these are small templates,
      # after all)
      # self[:template] = Base64.encode64(Marshal.dump(liquid_template))
      self[:template] = Marshal.dump(liquid_template)
    end
  end

end
