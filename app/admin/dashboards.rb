ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  section "Welcome", priority: 1 do
    div "Look at the menu at the top for the good stuff"
  end

  section "The Dashboard", priority: 2 do
    div 'What should we do with this space??'
  end

  section "This is a Section", priority: 3, icon: :pin do
    div 'These are sections.<br> They can have icons'.html_safe
  end

  section "Columns", priority: 4 do
    div "As you can see, they float into nice little columns. This is column A."
  end

  section "Column B", priority: 5 do
    div "They auto adjust to fit their contents"
  end

  section "Column C", priority: 6 do
    div "This column is small<br> because it's contents<br> are not that wide".html_safe
  end

  # section "Recent Service Providers"
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }
end


# This is here to let CanCan authorize the dashboards resource
class Dashboard; end