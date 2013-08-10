require 'pp'

class SessionsController < ApplicationController

  def create
  #  user = User.find_by_email(params[:email])
  #  if user && user.authenticate(params[:password])
  #    session[:user_id] = user.id
  #    redirect_to root_url, :notice => "Logged in!"
  #  else
  #    flash.now.alert = "Invalid email or password"
  #    render "new"
  #  end
  #
  #end
  #
  #
  #def create_with_google
    auth = request.env['omniauth.auth']
    session[:auth_token] = auth[:credentials][:token]
    session[:expires_at] = auth[:credentials][:expires_at].to_i
    session[:calendars] = {}
    session[:email] = auth[:info][:email]
    redirect_to calendars_url

    #respond_to do |format|
    #  format.html { redirect_to root_url, :notice => "Signed in!" }
    #  format.mobile { redirect_to root_url, :notice => "Signed in!" }
    #end
  end

end
