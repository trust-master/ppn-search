class DiscountsController < InheritedResources::Base
  belongs_to :company
  actions :all, except: [:show]

  load_and_authorize_resource :company
  load_and_authorize_resource :discount, through: :company

  layout 'companies'

  respond_to :html, :json


end
