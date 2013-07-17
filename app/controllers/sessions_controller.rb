require 'pp'

class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    session[:auth_token] = auth[:credentials][:token]

    session[:calendars] = {}

    google_data.calendar_list.data.items.each { |calendar| session[:calendars][calendar.summary] = calendar.id }

    @result = google_data.list_events(session[:calendars]['Plan'], {start_time: Time.new.strftime("%FT%T%:z"),
                                                                     end_time: (Time.new + 5.hours).strftime("%FT%T%:z")}).data


    #respond_to do |format|
    #  format.html { redirect_to root_url, :notice => "Signed in!" }
    #  format.mobile { redirect_to root_url, :notice => "Signed in!" }
    #end
  end

end
