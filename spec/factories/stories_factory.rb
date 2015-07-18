FactoryGirl.define do
  factory :story do
    title Faker::Lorem.sentence(3, false, 4)
    url Faker::Internet.url('s3-us-west-2.amazonaws.com', "/callmeishmael-files/#{SecureRandom.uuid}.ogg")

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

    factory :venue_story, traits: [:venue_story]
    factory :fixed_story, traits: [:fixed_story]
    factory :ishmaels_story, traits: [:ishmaels_story]
    factory :postroll_story, traits: [:postroll_story]

  end
end