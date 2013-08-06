class User < ActiveRecord::Base

  has_many :events
  has_many :tasks
  has_many :activities
  has_many :categories
  has_many :locations

  attr_accessible :email, :first_name, :last_name
end
