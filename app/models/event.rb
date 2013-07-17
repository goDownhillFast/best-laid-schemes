class Event < ActiveRecord::Base

  belongs_to :location
  belongs_to :activity
  belongs_to :user

  attr_accessible :activity_id, :end_time, :google_event_id, :location_id, :name, :start_time
end
