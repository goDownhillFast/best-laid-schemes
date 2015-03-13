FactoryGirl.define do
  factory :user do
    first_name "Johnny"
    last_name "Planner"
    sequence(:email) {|n| "plannerboy#{n}@zzzzzz.com"}

    factory :user_with_categories do
      after(:create) do |user|
        5.times {create(:category, user: user)}
      end
    end

    factory :user_with_categories_and_activities do
      after(:create) do |user|
        5.times {create(:category_with_activities, user: user, planning_user: user)}
      end
    end
  end

  factory :category do
    ignore do
      planning_user nil
    end

    sequence(:name) {|n| "category#{n}"}
    sequence(:budget) {|n| (n + 1) / 2}

    factory :category_with_activities do
      after(:create) do |category|
        5.times {create(:activity, category: category, user: planning_user)}
      end
    end
  end

  factory :activity do
    sequence(:name) {|n| "activity#{n}"}
    repeating true
    sequence(:budget) {|n| n}
  end

end