require 'google_data'
require 'pp'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_window_activities, :google_data, :current_user, :all_activities

  def current_window_activities(window_date_time=nil)
    window_date_time = window_date_time || Time.new
    windows = Window.all
    windows.reject { |window| !window.is_right_now?(window_date_time) | !window.activity.plan_for_week.present? }
  end

  def google_data
    GoogleData.new(session[:auth_token])
  end

  def current_user
    if session[:expires_at] && DateTime.new < Time.at(session[:expires_at]).to_datetime && session[:auth_token]
      @current_user
    else
      @current_user = User.find_or_create_with_google_data(session[:auth_token])
    end
  end

  def get_category_totals(opts={})
    opts[:singleEvents] ||= true
    calendar_data = google_data.list_events(opts)
    decoded_calendar_data = ActiveSupport::JSON.decode(calendar_data.body)['items']

    if decoded_calendar_data.nil?
    else
      decoded_calendar_data.reject! { |item| item['summary'][0..2].to_i == 0 }

      elapsed_time = opts[:timeMax] - opts[:timeMin]
      category_totals = get_all_categories

      convert_gcal_data(decoded_calendar_data).each do |key, val|
        cat_key = val[:category][:id]
        category_totals[cat_key][:activities][key][:total] = val[:events].inject(0) { |sum, hash| sum + hash[:time] }
      end

      category_totals.each do |key, val|
        val[:total] = val[:activities].inject(0) { |sum, (key, value)| sum + value[:total] }
        val[:average] = val[:total] / elapsed_time
      end

      category_totals
    end

  end

  def convert_gcal_data(calendar_data)

    gcal_data_by_category = {}

    activities = all_activities

    calendar_data.each do |item|
      g_activity_id = item['summary'][0..2].to_i
      this_activity = activities[g_activity_id]
      next if this_activity.nil?

      activity = gcal_data_by_category[g_activity_id] ||= {events: [],
                                                           category: {id: activities[g_activity_id][:category][:id]}}
      activity[:events] << {
          name: item['summary'],
          google_event_id: item['id'],
          time: (Time.parse(item['end']['dateTime']) - Time.parse(item['start']['dateTime']))/3600}
    end
    gcal_data_by_category
  end


  def all_categories
    @all_categories ||= get_all_categories
  end

  def get_all_categories
    all_categories = {}
    Category.all.each do |category|
      all_categories[category.id] ||= {total: 0, average: 0}
      all_categories[category.id][:name] = category.name
      all_categories[category.id][:activities] ||= {}
      category.activities.each do |activity|
        all_categories[category.id][:activities][activity.old_id] ||= {total: 0, average: 0}
        all_categories[category.id][:activities][activity.old_id][:name] = activity.name
      end
    end
    all_categories
  end


  def all_activities
    @all_activities ||= get_all_activities
  end

  def get_all_activities
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
