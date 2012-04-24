class PagesController < ApplicationController
  authorize_resource

  def show
    @page = Rails.cache.fetch([:page, params[:slug]]) do
      Page.where(slug: params[:slug]).first or raise ActionController::RoutingError.new('Page Not Found')
    end
  end

  private

    attr_reader :page
    helper_method :page

end