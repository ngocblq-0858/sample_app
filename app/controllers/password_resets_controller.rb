class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".flash_info_email_password_reset"
      redirect_to root_url
    else
      flash.now[:danger] = t ".flash_danger_email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t ".flash_success_password_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
    flash.now[:danger] = t ".flash_danger_user_not_found"
    redirect_to root_url unless @user
  end

  # Confirms a valid user.
  def valid_user
    redirect_to root_url unless @user &&
                                @user.activated? &&
                                @user.authenticated?(:reset, params[:id])
  end

  # Checks expiration of reset token.
  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = "password_resets.flash_success_password_reset_expired"
    redirect_to new_password_reset_url
  end
end
