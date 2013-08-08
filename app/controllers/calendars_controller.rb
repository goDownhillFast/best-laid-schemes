require 'pp'
require 'active_support/all'
class CalendarsController < ApplicationController


  def index
    current_user

    right_now = DateTime.now
    week_ago = Time.now - 7.days

    custom_start_month = DateTime.new(right_now.year, 7, 16)

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

    today_compare = get_category_totals({timeMin: right_now.at_beginning_of_day,
                                             timeMax: right_now.at_beginning_of_day + 1.day})

    last_week_compare = get_category_totals({timeMin: right_now.at_beginning_of_day - 7.days,
                                             timeMax: right_now.at_beginning_of_day - 6.days})

    future = get_category_totals({timeMin: right_now,
                                      timeMax: right_now + 1.week})

    one_week_ago = get_category_totals({timeMin: right_now - 1.week,
                                          timeMax: right_now})

    two_weeks_ago = get_category_totals({timeMin: right_now - 2.weeks,
                                        timeMax: right_now - 1.week})

    three_weeks_ago = get_category_totals({timeMin: right_now - 3.weeks,
                                         timeMax: right_now - 2.weeks})
    @categories = Category.includes(:activities).all

    @time_periods = [today_compare,last_week_compare,future,one_week_ago,two_weeks_ago,three_weeks_ago]

  end

end
