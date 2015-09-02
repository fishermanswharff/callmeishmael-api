FactoryGirl.define do
  factory :phonelog do
    log_content { File.read("#{Rails.root}/spec/support/fixtures/sample_log.txt") }
    association :phone, :with_buttons
  end
end