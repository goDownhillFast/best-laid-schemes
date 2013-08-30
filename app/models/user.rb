class User < ActiveRecord::Base

  has_many :activities
  has_many :categories

  attr_accessible :email, :first_name, :last_name
end
