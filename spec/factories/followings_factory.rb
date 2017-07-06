FactoryGirl.define do
  factory :following do
    association :follower
    association :followed
  end
end
