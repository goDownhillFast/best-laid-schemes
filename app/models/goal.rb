class Goal < ActiveRecord::Base

  belongs_to :activity

  delegate :category, :to => :activity, :allow_nil => true

  attr_accessible :activity_id, :hours_remaining, :total_hours
end
