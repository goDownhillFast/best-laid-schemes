require 'pp'
require 'active_support/all'
class BudgetController < ApplicationController

  def index
    current_user

    right_now = DateTime.now # - session[:time_zone_offset].hours only use if you need beginning_of_day

    @today_compare = get_category_totals({timeMin: right_now,
                                          timeMax: right_now + 1.hour})

    @last_week_compare = get_category_totals({timeMin: right_now - 7.days,
                                              timeMax: right_now - 6.days})

    #@last_week_this_week_diff = all_categories.each do |key, val|
    #  val[:total] = @today_compare[key][:total] - @last_week_compare[key][:total]
    #  val[:activities].each do |k,v|
    #    v[:total] = @today_compare[key][:activities][k][:total] - @last_week_compare[key][:activities][k][:total]
    #  end
    #end

    @one_week_ago = get_category_totals({timeMin: right_now - 1.week,
                                         timeMax: right_now})

    @next_week = get_category_totals({timeMin: right_now,
                                         timeMax: right_now + 1.week})

    @categories = current_user.categories.includes(:activities).all

  end


  def get_category_totals(opts={})
    opts[:singleEvents] ||= true
    opts[:calendarId] = session[:calendar_id]
    calendar_data = google_data.list_events(opts)
    decoded_calendar_data = ActiveSupport::JSON.decode(calendar_data.body)['items']

    if !decoded_calendar_data.nil?
      #decoded_calendar_data.reject! { |item| item['summary'][0..2].to_i == 0 }

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
      next if item['status'] == "cancelled"
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
    if !current_user.categories
      []
    else
      all_categories = {}
      current_user.categories.all.each do |category|
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
  end


  def all_activities
    @all_activities ||= get_all_activities
  end

  def get_all_activities
    if !current_user.activities
      []
    else
      all_activities = {}
      current_user.activities.all.each do |activity|
        all_activities[activity.old_id] ||= {}
        all_activities[activity.old_id][:name] = activity.name
        all_activities[activity.old_id][:category] ||= {}
        all_activities[activity.old_id][:category][:id] = activity.category.id
        all_activities[activity.old_id][:category][:name] = activity.category.name
      end
      all_activities
    end
  end

end
