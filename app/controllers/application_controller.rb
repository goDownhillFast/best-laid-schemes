require 'google_data'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_window_activities, :google_data, :current_user
  def current_window_activities(window_date_time=nil)
    window_date_time = window_date_time || Time.new
    windows = Window.all
    windows.reject { |window|  !window.is_right_now?(window_date_time) | !window.activity.plan_for_week.present? }
  end

  def google_data
    GoogleData.new(session[:auth_token])
  end

  def current_user
    @current_user ||= User.find_or_create_with_google_data(session[:auth_token]) if session[:auth_token]
  end

end
