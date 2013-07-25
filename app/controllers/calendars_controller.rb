require 'pp'
require 'active_support/all'
class CalendarsController < ApplicationController

  def index



    #month_left = get_category_totals({timeMin: Time.new.strftime("%FT%T%:z"),
    #                                 timeMax: (Time.new.at_beginning_of_month.next_month).strftime("%FT%T%:z")})
    month_total = get_category_totals({timeMin: Time.new.at_beginning_of_month.strftime("%FT%T%:z"),
                         timeMax: (Time.new.at_beginning_of_month.next_month).strftime("%FT%T%:z")})

    @result = month_total

  end

end
