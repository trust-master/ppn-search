module ApplicationHelper
  def view_identifier
    [controller.controller_name, controller.action_name].join('#')
  end

  def dev_note(note = nil)
    content_tag :div, class: :dev_note do
      content_tag :span do
        note || yield
      end
    end
  end

  def hidden_if(boolean)
    boolean ? 'display: none;' : nil
  end
end
