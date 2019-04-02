class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == Settings.remember_me ? remember(user) : forget(user)
        redirect_back_or user
      else
        flash[:warning] = t ".flash_invalid_activation"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".flash_invalid_email_password"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
