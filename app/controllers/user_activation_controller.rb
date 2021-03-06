class UserActivationController < ApplicationController
  authorize_resource UserAuthToken

  before_filter :reset_session # just in case

  # The show action will be used when fullfilling the activation URL
  def show
    if @token = UserAuthToken.where(token: params[:id]).first! and @token.try(:active?)
      @user = @token.user
    else
      render :inactive, status: :gone # token expired; piss off || try again
    end
  end

  def update
    if @token = UserAuthToken.where(token: params[:id]).first! and @token.try(:active?)
      @user = @token.user

      @user.password, @user.password_confirmation =
        params[@token.class.name.underscore][:user].values_at(:password, :password_confirmation)

      if @user.save
        session[:user_id] = @user.id # Leave the user logged in
        @user.touch :logged_in_at

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