require 'event'

class ApplicationController < ActionController::Base
  protect_from_forgery

  def events
    @events ||= Event.new(session) if session
  end

  def time_zone_offset
    session[:time_zone_offset].hours
  end

  def right_now
    DateTime.now
  end

  def current_user
    @current_user ||= User.find_or_create_by_email(session[:email])
  end

  def beginning_of_week
    (right_now - session[:time_zone_offset].hours).beginning_of_week - session[:time_zone_offset].hours
  end

end

# JSON FROM EXPIRED TOKEN
#{
#    "error": {
#    "errors": [
#    {
#        "domain": "global",
#    "reason": "authError",
#    "message": "Invalid Credentials",
#    "locationType": "header",
#    "location": "Authorization"
#}
#],
#    "code": 401,
#    "message": "Invalid Credentials"
#}
#}
