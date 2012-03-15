module BusinessFilingDecorator

  def attributes_for_detailed_display
    a = {
      issuing_state: self.issuing_state.name,
      type:          self.type.name,
      status:        self.status.name
    }
    a.update self.attributes.except(*%w[id created_at updated_at fetched_at raw_data]).delete_if { |k,v| k =~ /_id$/ }
    a.symbolize_keys!

    Hash[a.map{ |key, value| [BusinessFiling.human_attribute_name(key), value] }]
  end

end