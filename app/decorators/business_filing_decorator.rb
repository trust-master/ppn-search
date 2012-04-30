module BusinessFilingDecorator

  def attributes_for_detailed_display
    a = {
      issuing_state: self.issuing_state.name,
      type:          self.type.name,
      status:        self.status.name
    }
    a.update self.attributes.except(*%w[id created_at updated_at fetched_at raw_data]).delete_if { |k,v| k =~ /_id$/ }
    a.symbolize_keys!

    if addr = self.registered_office_address
      a[:registered_office_address] = link_to_blank_tab( addr, url_for_google_maps_search(addr) )
    end

    Hash[a.map{ |key, value| [BusinessFiling.human_attribute_name(key), value] }]
  end

end