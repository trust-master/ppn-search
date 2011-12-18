class CollectionInput < SimpleForm::Inputs::CollectionInput
  def input
    case self.input_type
    when :select
      "<div class='select-wrap'>#{super}</div><div class='clear'></div>".html_safe
    when :radio
      "<div class='radio'>\n#{super}\n</div>".html_safe
    else
      super
    end
  end
end
