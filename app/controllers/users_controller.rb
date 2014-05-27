class UsersController < ApplicationController
  # inherited resources
  # belongs_to :company
  # actions :all, except: [:show]

  # CanCan
  load_and_authorize_resource :company
  load_and_authorize_resource through: :company

  layout 'companies'

  respond_to :html, :json

end
