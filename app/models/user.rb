class User < ActiveRecord::Base

  has_many :events
  has_many :tasks
  has_many :activities
  has_many :categories
  has_many :locations

  def self.find_or_create_with_google_data(auth_token)

  end

  attr_accessible :email, :first_name, :last_name
end
