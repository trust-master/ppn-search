::Version.class_eval do

  attr_accessible :item_type, :item_id, :event, :object, :object_changes, :whodunnit, :ip_address, :controller_name, as: [:administrator, :company_admin, :user, :default]

end
