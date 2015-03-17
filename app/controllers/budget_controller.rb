require 'active_support/all'
class BudgetController < ApplicationController

  def index
    right_now = DateTime.now

    beginning_point = (right_now - session[:time_zone_offset].hours).beginning_of_week - session[:time_zone_offset].hours

    @this_week_to_date = events.where({time_min: beginning_point,
                                          time_max: right_now})

    @last_week_to_date = events.where({time_min: beginning_point - 7.days,
                                              time_max: right_now - 7.days})

    @categories = current_user.categories.includes(:activities).all

  end
end
