module TabsHelper

  def tab_for(record, section_name = nil, &block)
    klass = [dom_class(record), section_name].compact.join(?_)
    klass = [klass, section_name, :tab].compact
    content_tag :div,
        id: tab_id_for(record, section_name),
        class: klass,
        data: { edit_path: edit_company_section_path(record, section_name) },
        &block
  end

  def tab_id_for(record, section_name = nil)
    [dom_id(record), section_name].compact.join(?_)
  end


end