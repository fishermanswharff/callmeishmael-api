FactoryGirl.define do
  factory :phonelog do
    log_content { File.read("#{Rails.root}/spec/support/fixtures/sample_log.txt") }
    association :phone, :with_buttons

    trait :with_listens do
      log_content { File.read("#{Rails.root}/spec/support/fixtures/log_with_listens.txt") }
    end

    trait :associated_phone do
      after(:create) do |phonelog, evaluator|
        if evaluator.phone
          phonelog.phone = phone
        else
          phonelog.phone = create(:phone)
        end
      end
    end
  end
end