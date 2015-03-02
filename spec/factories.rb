FactoryGirl.define do
  factory :user do
    first_name "Johnny"
    last_name "Planner"
    sequence(:email) {|n| "plannerboy#{n}@zzzzzz.com"}
  end
end