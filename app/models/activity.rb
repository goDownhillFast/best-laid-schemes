class Activity < ActiveRecord::Base

  belongs_to :category
  belongs_to :user

  has_many :goals
  has_many :weekly_plans
  has_many :windows
  has_many :locations
  has_many :events


  def plan_for_week(plan_date=nil)
    plan_date = (plan_date || Time.new.beginning_of_week)
    plan = weekly_plans.find_by_start_date(plan_date)
    plan.number_of_hours if plan.present?
  end

  attr_accessible :category_id, :name, :repeating, :old_id, :budget
end
