FactoryGirl.define do
  factory :like do
    association :user
    association :note
  end
end
