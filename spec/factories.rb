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
  end

  factory :category do
    sequence(:name) {|n| "category#{n}"}
    sequence(:budget) {|n| (n + 1) / 2}
  end
end