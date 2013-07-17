class Window < ActiveRecord::Base

  belongs_to :activity

  def is_right_now?(window_date=nil)
    right_now = window_date || Time.new
    week_begin = right_now.beginning_of_week
    begin_window_this_week = week_begin + day_of_week.days + begin_time.hours
    end_window_this_week = week_begin + day_of_week.days + end_time.hours
    right_now >= begin_window_this_week && right_now < end_window_this_week
  end

  attr_accessible :activity_id, :begin_time, :end_time, :day_of_week
end
