require 'pp'

class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    session[:auth_token] = auth[:credentials][:token]

    session[:calendars] = {}

    google_data.calendar_list.data.items.each { |calendar| session[:calendars][calendar.summary] = calendar.id }

    redirect_to root_url

    #respond_to do |format|
    #  format.html { redirect_to root_url, :notice => "Signed in!" }
    #  format.mobile { redirect_to root_url, :notice => "Signed in!" }
    #end
  end

end
