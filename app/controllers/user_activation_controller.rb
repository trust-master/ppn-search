class UserActivationController < ApplicationController
  authorize_resource UserAuthToken

  # The show action will be used when fullfilling the activation URL
  def show
    @token = UserAuthToken.where(token: params[:id]).first!
    if @token and @token.active?
      @user = @token.user
    else
      render :inactive, status: :gone # token expired; piss off || try again
    end
  end

  def update
    @token = UserAuthToken.where(token: params[:id]).first!
    if @token and @token.active?
      @user = @token.user

      @user.password, @user.password_confirmation =
        params[@token.class.name.underscore][:user].values_at(:password, :password_confirmation)

      if @user.save
        session[:user_id] = @user.id # Leave the user logged in

        @token.fullfill! # keep track of when this happened and invalidate the token

        flash[:notice] = t('success', scope: 'user_activation.update').html_safe
        redirect_to root_url
      else
        logger.debug @user.errors.inspect
        flash.now[:error] = t('failure', scope: 'user_activation.update')
        render :show
      end

    else
      # token expired; piss off || try again
      render :inactive, status: :gone
    end
  end
end