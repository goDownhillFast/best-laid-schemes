class Location < ActiveRecord::Base

  has_many :events

  belongs_to :activity
  belongs_to :event
  belongs_to :user

  attr_accessible :activity_id, :latitude, :longitude
end
