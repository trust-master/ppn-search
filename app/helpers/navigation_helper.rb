module NavigationHelper

  # Create sidebar navigation menu. Give it a name and a block where you call <tt>nav_link</tt>
  def nav_for(menu_name, opts = {}, &block)
    menu = NavigationMenu.new(menu_name, self, opts)
    content_tag :ul, class: [:navigation, menu_name, opts[:menu_class]] do
      # menu.instance_eval(&block)
      block.call(menu)
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
    def nav_link(name, url_for_opts = nil, active_proc = nil, html_options = {})
      name_for_path = name.is_a?(Symbol) ? name : name.parameterize(?_)
      path = [menu_name, name_for_path].flatten.join(?.)
      text_for_link = name.is_a?(Symbol) ? h.t("#{path}._label", scope: :nav, default: path.to_sym) : name

      url = h.url_for(url_for_opts)
      options = @options.dup

      html_options[:class] = [*html_options[:class]] # wrap in array if not array
      html_options[:class] << options[:item_class] # add the menu-level class
      html_options[:class].collect!{|c| c.presence.try(:to_s) }
      html_options[:class].compact!
      html_options[:class] << 'active' if active_proc.is_a?(Proc) ? active_proc.call : current_page?(url)
      html_options.delete(:class) if html_options[:class].empty?

      options[:link_attrs] = {id: path}.merge(options[:link_attrs] || {})

      if options.has_key?(:item_wrapper) and options[:item_wrapper].nil?
        h.link_to(url, options[:link_attrs].merge(html_options)) do
          out = text_for_link
          out << content_tag(:abbr, '', class: 'arrow') if options[:include_arrow]
          out.html_safe
        end
      else
        wrapper_tag = options[:item_wrapper] || :li
        h.content_tag(wrapper_tag, html_options) do
          h.link_to(url, options[:link_attrs]) do
            out = text_for_link
            out << content_tag(:abbr, '', class: 'arrow') if options[:include_arrow]
            out.html_safe
          end
        end
      end
    end

    def nav_page_link(name, html_options = {})
      page = page_info(name)

      if page or Rails.env.production? # don't do the new_page link on production. We don't want folks getting access denied errors when they click on a link to "Terms of Use", ya know? Shouldn't ever be a problem, but just in case one page gets forgotten
        nav_link(page[:title], page[:slug], nil, html_options)
      else
        html_options[:class] = [*html_options[:class]]
        html_options[:class] << :page_not_found
        html_options[:title] = "A page with this name does not yet exist, click here to create it."
        nav_link(name, new_admin_page_path(name: name), nil, html_options)
      end
    end

    def nav_for(menu_name, opts = {}, &block)
      h.nav_for [self.menu_name, menu_name], opts, &block
    end

    # delegate helpers to the view
    def method_missing(*args, &block)
      h.send(*args, &block)
    end
  end

end