class DebugController < ApplicationController
  authorize_resource :admin

  # This is exactly the same as rake routes, in the browser. Handy when you've got a development
  # server running already and you don't want to wait 3 minutes for the app to initialize for the
  # rake task.
  def routes
    Rails.application.reload_routes!
    all_routes = Rails.application.routes.routes

    require 'rails/application/route_inspector'
    inspector = Rails::Application::RouteInspector.new

    @routes = inspector.collect_routes(all_routes)
  end


  def design
    # @colors = Sass::Engine.for_file(Rails.root.join('app/assets/stylesheets/_colors.sass'))
    @fonts = Rails.cache.fetch('fonts_list_for_design_page') do
      fonts = {}
      engine = Sass::Engine.for_file(Rails.root.join('app/assets/stylesheets/_fonts.sass').to_s, {})
      engine.to_tree.children.each do |n|
        if n.is_a?(Sass::Tree::VariableNode)
          list = n.expr.to_s.gsub('"','').split(/,\s*/)
          fonts[n.name] = list
        end
      end
      fonts
    end
  end

end