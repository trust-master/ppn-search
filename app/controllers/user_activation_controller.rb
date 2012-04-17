class UserActivationController < InheritedResources::Base
  respond_to :html, :json

  actions :show, :edit, :update
  defaults resource_class: UserAuthToken, instance_name: :token

  load_and_authorize_resource :user_auth_token

  private

    def resource
      @token ||= end_of_association_chain.where(token: params[:id]).first!
    end
end