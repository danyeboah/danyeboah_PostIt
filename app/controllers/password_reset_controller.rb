class PasswordResetController < ApplicationController
  def new; end

  def confirm_password
    @user = current_user
  end

  def auth_confirm_password
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      @user.generate_token(:password_reset_token)
      @user.password_reset_sent_at = Time.zone.now
      @user.save
      flash["notice"] = "Authentication complete"
      redirect_to edit_password_reset_path(@user.password_reset_token)
    else 
      flash[:error] = "Authentication failed"
      redirect_to confirm_user_path
    end
  end

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
      cookies.signed[:auth_token] = @user.auth_token
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit!
  end


end
