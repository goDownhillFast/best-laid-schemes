require 'active_support/all'
class BudgetController < ApplicationController

  before_filter :events
  helper_method :event_day_activity_total

  def index
    @this_week_to_date = events.where({time_min: beginning_of_week,
                                          time_max: right_now})

    @last_week = events.where({time_min: beginning_of_week - 7.days,
                                              time_max: beginning_of_week})

    @categories = current_user.categories.includes(:activities).all
  end

  def event_day_activity_total(old_id, i)
    selected_events = @this_week_to_date.select do |event|
      event[:old_activity_id] === old_id && event[:start].wday === i
    end
    selected_events.map { |e| e[:time] }.reduce(:+)
  end
end
