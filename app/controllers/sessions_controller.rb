require 'google_calendar'

class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    auth_token = auth[:credentials][:token]

    google_calendar = GoogleCalendar.new(auth_token)

    session[:auth_token] = auth_token
    session[:expires_at] = auth[:credentials][:expires_at].to_i
    session[:calendars] = {}
    session[:email] = auth[:info][:email]
    session[:time_zone] = google_calendar.get_time_zone
    session[:time_zone_offset] = DateTime.now.in_time_zone(session[:time_zone]).utc_offset/3600 - DateTime.now.utc_offset/3600

    session[:calendar_id] = google_calendar.find_calendar_id

    redirect_to budget_url
  end

  def destroy
    reset_session
    redirect_to root_url
  end

end
