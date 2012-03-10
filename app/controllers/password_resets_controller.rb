class PasswordResetsController < ApplicationController
  authorize_resource

  # show the form to get email and first name
  def new
    @password_reset = PasswordResetRequest.new
  end

  # check the email exists and that the corresponding user's first name matches the one given. Then,
  # create a new PasswordReset for that user.
  def create
    email, name = params['password_reset_request'].values_at('email', 'name')
    user = User.where('lower("email") = ?', email.downcase.strip).first

    if user and user.first_name.downcase.strip == name.downcase.strip

      token = user.password_resets.create(created_by_ip: request.ip)

      UserMailer.password_reset(token).deliver

      render :success

    else
      redirect_to new_password_reset_path, flash: { error: t('failure', scope: ['password_resets.new']) }
    end
  end

  # The show action will be used when fullfilling the reset (the reset URL will point to this)
  def show
    @token = PasswordReset.find_by_token(params[:id])
    if @token and @token.active?
      @user = @token.user
    else
      render :inactive, status: :gone
    end
  end

  def update
    @token = PasswordReset.find_by_token(params[:id])
    if @token and @token.active?
      @user = @token.user

      @user.password, @user.password_confirmation =
        params[:password_reset][:user].values_at(:password, :password_confirmation)

      if @user.save
        session[:user_id] = @user.id # Leave the user logged in

        @token.fullfill!(request.ip)

        flash[:notice] = t('success', scope: ['password_resets.update'])
        redirect_to root_url
      else
        flash.now[:error] = t('failure', scope: ['password_resets.update'])
        render :show
      end
    else
      render :inactive, status: :gone
    end
  end
end