require 'active_support/all'
class BudgetController < ApplicationController

  before_filter :events
  helper_method :time_by_activity, :day_name

  def index
    @this_week = events.where({time_min: beginning_of_week,
                                          time_max: beginning_of_week + 7.days})

    @last_week = events.where({time_min: beginning_of_week - 7.days,
                                              time_max: beginning_of_week})

    @categories = current_user.categories.includes(:activities).all
  end

  def time_by_activity(event_set, old_activity_id, i = nil)
    if i
      event_set.select! do |event|
        event[:old_activity_id] === old_activity_id && event[:start].wday === i
      end
    end

    event_set.map { |e| e[:time] }.reduce(:+)
  end

  def day_name(i)
    (beginning_of_week + i.days).strftime('%a')
  end
end
