class InverseBooleanInput < SimpleForm::Inputs::BooleanInput
  def input
    @builder.check_box(attribute_name, input_html_options, false, true)
  end
end