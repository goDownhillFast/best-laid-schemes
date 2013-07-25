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

  def get_category_totals(opts={})
    opts[:singleEvents] ||= true
    calendar_data = google_data.list_events(opts)
    parsed_calendar_data = convert_google_calendar_data(calendar_data)
    category_totals = {}
    pp parsed_calendar_data.count
    parsed_calendar_data.each do |item|
      category_totals[item[:category_name]] ||= {}
      category_totals[item[:category_name]][:total_time] ||= 0
      category_totals[item[:category_name]][:total_time] += item[:time]
      category_totals[item[:category_name]][item[:activity_name]] ||= 0
      category_totals[item[:category_name]][item[:activity_name]] += item[:time]
    end
    category_totals
  end

  def convert_google_calendar_data(calendar_data)
    calendar_data = ActiveSupport::JSON.decode(calendar_data.body)['items']
    parsed_calendar_data = []
    all_activities = {}

    calendar_data.each do |item|
      activity_id = item['summary'][0..2].to_i
      related_activity = Activity.includes(:category).find_by_old_id(activity_id)
      parsed_calendar_data << {
          category_id: related_activity.category_id,
          category_name: related_activity.category.name,
          activity_id: activity_id,
          activity_name: related_activity.name,
          title: item['summary'],
          time: (Time.parse(item['end']['dateTime']) - Time.parse(item['start']['dateTime']))/3600} unless activity_id == 0
    end
    parsed_calendar_data.sort_by! {|hash| hash[:category_id]}
  end

end

#
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
