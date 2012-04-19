class AccountsController < InheritedResources::Base
  defaults resource_class: User, collection_name: :users, instance_name: :user
  actions :edit, :update
  acts_as_singleton!
  load_and_authorize_resource :user

  layout 'account'

  respond_to :html, :json

  def update
    update!(notice: t('accounts.saved'))
  end

  def edit
    super do |format|
      format.html { render(params[:section] || :edit) }
    end
  end

  protected

  def resource
    current_user
  end
end