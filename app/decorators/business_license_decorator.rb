module BusinessLicenseDecorator

  def attributes_for_detailed_display
    a = {
      issuing_state: self.issuing_state.name,
      type:          self.type.name,
      status:        self.status.name
    }
    a.update self.attributes.except(*%w[id created_at updated_at fetched_at raw_data]).delete_if { |k,v| k =~ /_id$/ }
    a.symbolize_keys!

    a[:enforcement_action] = self.enforcement_action ? 'Yes' : 'No'

    Hash[a.map{ |key, value| [BusinessLicense.human_attribute_name(key), value] }]
  end
end