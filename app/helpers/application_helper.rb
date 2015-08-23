module ApplicationHelper
  #fix url
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  # format time
  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end


    dt.strftime("%m/%d/%Y %l:%M%P %Z") #03/14/2014 9:09pm
  end
end
