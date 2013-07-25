require 'google_data'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_window_activities, :google_data, :current_user

  def current_window_activities(window_date_time=nil)
    window_date_time = window_date_time || Time.new
    windows = Window.all
    windows.reject { |window| !window.is_right_now?(window_date_time) | !window.activity.plan_for_week.present? }
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
    parsed_calendar_data.each do |item|
      category_totals[item[:category][:name]] ||= {}
      category_totals[item[:category][:name]][:total] ||= 0
      category_totals[item[:category][:name]][:total] += item[:time]
      category_totals[item[:category][:name]][:activities] ||= {}
      category_totals[item[:category][:name]][:activities][item[:name]] ||= 0
      category_totals[item[:category][:name]][:activities][item[:name]] += item[:time]
    end
    category_totals
  end

  def convert_google_calendar_data(calendar_data)
    calendar_data = ActiveSupport::JSON.decode(calendar_data.body)['items'].reject! { |item| item['summary'][0..2].to_i == 0 }
    parsed_calendar_data = []

    activities = all_activities

    calendar_data.each do |item|
      google_activity_id = item['summary'][0..2].to_i
      this_activity = activities[google_activity_id]

      parsed_calendar_data << {
          name: this_activity[:name],
          category: {id: this_activity[:category][:id],
                     name: this_activity[:category][:name]},
          title: item['summary'],
          google_event_id: item['id'],
          time: (Time.parse(item['end']['dateTime']) - Time.parse(item['start']['dateTime']))/3600}
    end
    parsed_calendar_data.sort_by! {|data| data[:category][:id]}
  end

  def all_activities
    all_activities = {}
    Activity.all.each do |activity|
      all_activities[activity.old_id] ||= {}
      all_activities[activity.old_id][:name] = activity.name
      all_activities[activity.old_id][:category] ||= {}
      all_activities[activity.old_id][:category][:id] = activity.category.id
      all_activities[activity.old_id][:category][:name] = activity.category.name
    end
    all_activities
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
