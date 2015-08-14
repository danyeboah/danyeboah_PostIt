module ApplicationHelper
  #fix url
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  # format time
  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z") #03/14/2014 9:09pm
  end

  # check if current user is an administrator
  def is_admin?(user)
    if user && (user.user_status == 'admin')
      return true
    else
      return false
    end
  end

  # check if current user created post or comment
  def is_creator?(submission)
    if logged_in? && (submission.user_id == current_user.id)
      return true
    else
      return false
    end
  end


end
