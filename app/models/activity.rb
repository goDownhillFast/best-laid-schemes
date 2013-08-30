class Activity < ActiveRecord::Base

  attr_accessible :category_id, :name, :repeating, :old_id, :budget

  validate :activities_sum_is_less_than_category

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

  private

  def activities_sum_is_less_than_category
    activities_sum = category.activities.map {|m| m.budget || 0}.reduce(0, :+)
    category_budget = category.budget || 0

    errors.add(:activity, "should be less than the category total of " + category_budget.to_s + " hours.") if activities_sum > category_budget
  end

end
