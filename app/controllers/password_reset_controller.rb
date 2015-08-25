class PasswordResetController < ApplicationController
  def new; end


  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset_email if user
    flash["notice"] = "An email with reset instructions has been sent to you"
    redirect_to login_path
  end


  def show; end

  def edit
    @user = User.find_by!(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by!(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 10.minutes.ago
      flash[:error] = "Password reset has expired"
      redirect_to new_password_reset_path
    elsif @user.update(user_params)
      flash["notice"] = "Your profile was updated"
      redirect_to edit_user_path(@user)
    end
  end


  private

  def user_params
    params.require(:user).permit!
  end


end
