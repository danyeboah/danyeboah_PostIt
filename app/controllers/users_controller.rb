class UsersController < ApplicationController
  before_action :user_select, only: [:edit,:update,:show]
  before_action :require_user, only: [:edit,:update]

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    
    # make first user in database admin
    if User.any?
      @user.user_status = "member"
    else
      @user.user_status = "admin"
    end
    
    if @user.save
      flash["notice"] = "Your account has been created"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit

  end

  def update
     if @user.update(user_params)
      flash["notice"] = "Your profile was updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit!
  end

  def user_select 
    @user = User.find_by(slug: params[:id])
  end

  def require_user
    if current_user != @user
      flash[:error] = "You are not allowed to do that"
      redirect_to root_path
    end
  end

  

 



end