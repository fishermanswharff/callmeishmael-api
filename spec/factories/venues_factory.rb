FactoryGirl.define do
  factory :venue do
    name Faker::Company.name
    venue_status 'active'

    factory :venue_with_phone do
      transient do
        number_phones 1
      end
      after(:create) do |venue, evaluator|
        create_list(:phone, evaluator.number_phones, venue: venue)
      end
    end

    factory :venue_with_phone_and_buttons do
      transient do
        number_phones 1
      end
      after(:create) do |venue, evaluator|
        create_list(:phone, evaluator.number_phones, :with_buttons, venue: venue )
      end
    end

    factory :venue_with_stories do
      transient do
        story_count 1
      end
      after(:create) do |venue, evaluator|
        FactoryGirl.create_list(:story_associated_with_venue, evaluator.story_count, venues: [venue])
      end
    end
  end

  # trait :with_phone do
  #   association :phone
  # end

  # trait :with_phone_and_buttons do
  #   association :phone, :with_buttons
  # end

  # trait :with_stories do
  #   after(:create) do |venue, evaluator|
  #     if evaluator.stories
  #       venue.stories << evaluator.stories
  #     else
  #       venue.stories << FactoryGirl.create_list(:story_associated_with_venue, 32, venues: [venue])
  #     end
  #   end
  # end
end
