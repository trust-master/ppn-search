class DebugController < ApplicationController
  authorize_resource :admin

  def routes
    Rails.application.reload_routes!
    all_routes = Rails.application.routes.routes

    require 'rails/application/route_inspector'
    inspector = Rails::Application::RouteInspector.new

    @routes = inspector.collect_routes(all_routes)
  end

end