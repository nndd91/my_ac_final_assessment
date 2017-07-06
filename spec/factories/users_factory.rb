FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password "123123"
    firstname "John"
    lastname "Doe"
    sequence(:username) { |n| "user#{n}" }
  end
end
