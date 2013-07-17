class Task < ActiveRecord::Base

  belongs_to :category
  belongs_to :user

  attr_accessible :category_id, :complete, :day, :number_of_hours
end
