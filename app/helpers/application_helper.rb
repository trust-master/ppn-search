module ApplicationHelper
  def view_identifier
    [controller.controller_name, controller.action_name].join('#')
  end
end
