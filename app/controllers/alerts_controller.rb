class AlertsController < ApplicationController
  load_and_authorize_resource :company

  respond_to :html, :json

  layout 'companies'

  def index
    respond_with @company do |wants|
      wants.html { render :index, layout: 'companies'}
      wants.json
    end
  end
end