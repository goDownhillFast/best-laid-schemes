class WeeklyPlan < ActiveRecord::Base


  belongs_to :activity

  delegate :category, :to => :activity, :allow_nil => true

  attr_accessible :activity_id, :number_of_hours, :start_date
end
