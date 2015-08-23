class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:error] = "Please log in to do that"
      redirect_to root_path
    end
  end

  def require_user_to_vote
    unless logged_in?  
      flash["error"] = "You must be logged in to vote"
      
      if request.xhr?
        render js: "window.location.reload();" 
      else
        redirect_to :back
      end

    end
    
  end


  def require_admin
    deny_access unless logged_in? && current_user.is_admin?
  end

  def require_moderator
    deny_access unless logged_in? && current_user.is_moderator?
  end

  def deny_access
    flash[:error] = "You do not have the rights to do that"
    redirect_to root_path
  end





  
    
end
