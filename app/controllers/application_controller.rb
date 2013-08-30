require 'google_data'
require 'pp'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :google_data, :current_user

  def google_data
    GoogleData.new(session[:auth_token])
  end

  def current_user
    @current_user ||= User.find_or_create_by_email(session[:email])
  end

  def setup_orange_planner
    calendars_json = google_data.calendar_list.body
    parsed_calendars = ActiveSupport::JSON.decode(calendars_json)
    calendar_names = parsed_calendars['items'].map { |c| c['summary'] }
    google_data.new_orange_calendar unless calendar_names.include?('Orange Planner')
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
