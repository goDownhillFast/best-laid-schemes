require 'pp'
require 'active_support/all'
class CalendarsController < ApplicationController


  def index
    current_user

    right_now = DateTime.now + session[:time_zone_offset].hours

    #@month_left = get_category_totals({timeMin: right_now.strftime("%FT%T%:z"),
    #                                   timeMax: right_now.at_beginning_of_month.next_month.strftime("%FT%T%:z")})
    #
    #@month_total = get_category_totals({timeMin: right_now.at_beginning_of_month.strftime("%FT%T%:z"),
    #                                    timeMax: right_now.at_beginning_of_month.next_month.strftime("%FT%T%:z")})
    #
    #@custom_left = get_category_totals({timeMin: custom_start_month,
    #                                    timeMax: right_now.at_beginning_of_month.next_month.strftime("%FT%T%:z")})

    #@custom_so_far = get_category_totals({timeMin: custom_start_month,
    #                                      timeMax: right_now})

    @today_compare = get_category_totals({timeMin: right_now.at_beginning_of_day,
                                             timeMax: right_now.at_beginning_of_day + 1.day})

    @last_week_compare = get_category_totals({timeMin: right_now.at_beginning_of_day - 7.days,
                                             timeMax: right_now.at_beginning_of_day - 6.days})

    #future = get_category_totals({timeMin: right_now,
    #                                  timeMax: right_now + 1.week})

    @one_week_ago = get_category_totals({timeMin: right_now - 1.week,
                                          timeMax: right_now})

    #two_weeks_ago = get_category_totals({timeMin: right_now - 2.weeks,
    #                                    timeMax: right_now - 1.week})
    #
    #three_weeks_ago = get_category_totals({timeMin: right_now - 3.weeks,
    #                                     timeMax: right_now - 2.weeks})
    @categories = current_user.categories.includes(:activities).all

    #@weekly_time_periods = [one_week_ago,two_weeks_ago,three_weeks_ago]

    #@daily_time_periods = [today_compare,last_week_compare,future]

  end
  
  
  def get_category_totals(opts={})
    opts[:singleEvents] ||= true
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
