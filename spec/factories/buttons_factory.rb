FactoryGirl.define do
  factory :button do
    assignment '0'
    association :phone
    association :story
  end
end