require 'pp'

class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    session[:auth_token] = auth[:credentials][:token]
    session[:expires_at] = auth[:credentials][:expires_at].to_i
    session[:calendars] = {}
    session[:email] = auth[:info][:email]
    session[:time_zone] = google_data.get_time_zone
    session[:time_zone_offset] = DateTime.now.in_time_zone(session[:time_zone]).utc_offset/3600 - DateTime.now.utc_offset/3600

    setup_orange_planner

    redirect_to budget_url
  end

end
