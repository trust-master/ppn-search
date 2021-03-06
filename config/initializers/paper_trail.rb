PaperTrail::Version.module_eval do

  attr_accessible :item_type, :item_id, :event, :object, :object_changes, :whodunnit, :ip_address, :controller_name, as: [:administrator, :company_admin, :user, :default]

  belongs_to :whodunnit, class_name: User, foreign_key: 'whodunnit'
  def whodunnit=(value)
    case value
    when Numeric
      self[:whodunnit] = value
    when User
      super
    end
  end

  default_scope includes(:whodunnit)

  def changeset
    if self.class.column_names.include? 'object_changes'
      if changes = object_changes
        Changeset.new(YAML::load(changes))
      else
        Changeset.new
      end
    end
  end

  class Changeset < HashWithIndifferentAccess
    def to_html
      changed = self.map do |attr, changes|
        if attr == 'password_digest'
          "<strong>Password change</strong>"
        else
          "<strong>#{attr}:</strong> #{changes.map(&:inspect).join(' &#9654; ')}"
        end
      end
      changed.join('<br>').html_safe
    end

  end

end
