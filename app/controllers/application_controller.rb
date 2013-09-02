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
