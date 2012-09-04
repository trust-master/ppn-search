class GroupedCollectionSelectInput < SimpleForm::Inputs::GroupedCollectionSelectInput
  def input
    @input_html_options = { data: { placeholder: placeholder_text }}.deep_merge(@input_html_options || {})

    super
  end
end