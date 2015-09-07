FactoryGirl.define do
  factory :story do
    title { Faker::Lorem.sentence(3, false, 4) }
    url { Faker::Internet.url('s3-us-west-2.amazonaws.com', "/callmeishmael-files/#{SecureRandom.uuid}.ogg") }
    story_type { 'ishmaels' }
    author_first { Faker::Name.first_name }
    author_last { Faker::Name.last_name }
    placements { Faker::Number.digit }
    listens { Faker::Number.digit }
    call_length { '1:09' }
    common_title { Faker::Lorem.sentence }
    call_date { Faker::Date.between(2.days.ago, Date.today) }
    child_appropriate { true }
    gender { 'Female' }

    trait :venue_story do
      story_type 'venue'
    end

    trait :fixed_story do
      story_type 'fixed'
    end

    trait :ishmaels_story do
      story_type 'ishmaels'
    end

    trait :postroll_story do
      story_type 'postroll'
    end

    trait :male_caller do
      gender 'Male'
    end

    trait :explicit do
      explicit true
    end

    trait :spoiler_alert do
      spoiler_alert true
    end

    trait :not_appropriate_for_children do
      child_appropriate false
    end

    trait :associated_venue do
      after(:create) do |story, evaluator|
        if evaluator.venues.length > 0
          story.venues << evaluator.venues.first
        else
          story.venues << create(:venue)
        end
      end
    end

    factory :story_associated_with_venue, traits: [:venue_story,:associated_venue]
  end
end