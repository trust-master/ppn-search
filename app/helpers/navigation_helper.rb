module NavigationHelper

  # Create sidebar navigation menu. Give it a name and a block where you call <tt>nav_link</tt>
  def nav_for(menu_name, opts = {}, &block)
    menu = NavigationMenu.new(menu_name, self, opts)
    content_tag :ul, :class => [:navigation, menu_name, opts[:menu_class]] do
      menu.instance_eval &block
    end
  end

  # This is meant to be instantiated by a helper method, and will help build navigation sidebars
  class NavigationMenu
    # Initialize a new NavigationMenu
    def initialize(menu_name, view_context, opts = {})
      @h = view_context
      @menu_name = menu_name
      @options = opts
    end
    attr_reader :menu_name, :h, :options

    # Create a navigation menu item, the @name@ argument should be the I18n key under
    # <tt>nav.#{menu_name}</tt> for the title of the nav link being created.
    def nav_link(name, url_for_opts = nil, active_proc = nil)
      path = [menu_name, name].flatten.join('.')
      text_for_link = h.t("#{path}._label", scope: :nav, default: path.to_sym)
      url = h.url_for(url_for_opts)
      options = @options.dup
      options[:item_class] ||= []
      options[:item_class] << 'active' if active_proc.is_a?(Proc) ? active_proc.call : current_page?(url)

      if options.has_key?(:item_wrapper) and options[:item_wrapper].nil?
        h.link_to(text_for_link, url, options[:link_attrs])
      else
        wrapper_tag = options[:item_wrapper] || :li
        h.content_tag wrapper_tag, :class => options[:item_class] do
          h.link_to(text_for_link, url, options[:link_attrs])
        end
      end
    end

    def nav_for(menu_name, opts = {}, &block)
      h.nav_for [self.menu_name, menu_name], opts, &block
    end

    # delegate helpers to the view
    def method_missing(*args, &block)
      h.send *args, &block
    end
  end

end