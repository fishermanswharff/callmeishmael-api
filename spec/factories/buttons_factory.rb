
FactoryGirl.define do
  factory :button do
    assignment '1'
    association :phone
    association :story

    trait :button_star do
      assignment {'*'}
    end
    trait :button_hash do
      assignment {'#'}
    end
    trait :button_zero do
      assignment {'0'}
    end
    trait :button_one do
      assignment {'1'}
    end
    trait :button_two do
      assignment {'2'}
    end
    trait :button_three do
      assignment {'3'}
    end
    trait :button_four do
      assignment {'4'}
    end
    trait :button_five do
      assignment {'5'}
    end
    trait :button_six do
      assignment {'6'}
    end
    trait :button_seven do
      assignment {'7'}
    end
    trait :button_eight do
      assignment {'8'}
    end
    trait :button_nine do
      assignment {'9'}
    end
    trait :invalid_assignment_ß do
      assignment {'ß'}
    end
    trait :invalid_assignment_M do
      assignment {'M'}
    end
    trait :button_post_roll do
      assignment { 'PR' }
    end

    trait :fixed_story_button do
      association :story, :fixed_story
    end
    trait :venue_story_button do
      association :story, :venue_story
    end
    trait :ishmaels_story_button do
      association :story, :ishmaels_story
    end
    trait :postroll_story_button do
      association :story, :postroll_story
    end

    factory :star_button, traits: [:button_star, :fixed_story_button]
    factory :hash_button, traits: [:button_hash, :fixed_story_button]
    factory :zero_button, traits: [:button_zero, :fixed_story_button]
    factory :postroll, traits: [:button_post_roll, :postroll_story_button]

    factory :one_button_with_ishmael_story, traits: [:button_one, :ishmaels_story_button]
    factory :two_button_with_ishmael_story, traits: [:button_two, :ishmaels_story_button]
    factory :three_button_with_ishmael_story, traits: [:button_three, :ishmaels_story_button]
    factory :four_button_with_ishmael_story, traits: [:button_four, :ishmaels_story_button]
    factory :five_button_with_ishmael_story, traits: [:button_five, :ishmaels_story_button]
    factory :six_button_with_ishmael_story, traits: [:button_six, :ishmaels_story_button]
    factory :seven_button_with_ishmael_story, traits: [:button_seven, :ishmaels_story_button]
    factory :eight_button_with_ishmael_story, traits: [:button_eight, :ishmaels_story_button]
    factory :nine_button_with_ishmael_story, traits: [:button_nine, :ishmaels_story_button]

    factory :one_button_with_venue_story, traits: [:button_one, :venue_story_button]
    factory :two_button_with_venue_story, traits: [:button_two, :venue_story_button]
    factory :three_button_with_venue_story, traits: [:button_three, :venue_story_button]
    factory :four_button_with_venue_story, traits: [:button_four, :venue_story_button]
    factory :five_button_with_venue_story, traits: [:button_five, :venue_story_button]
    factory :six_button_with_venue_story, traits: [:button_six, :venue_story_button]
    factory :seven_button_with_venue_story, traits: [:button_seven, :venue_story_button]
    factory :eight_button_with_venue_story, traits: [:button_eight, :venue_story_button]
    factory :nine_button_with_venue_story, traits: [:button_nine, :venue_story_button]

    factory :invalid_button_ß, traits: [:invalid_assignment_ß]
    factory :invalid_button_M, traits: [:invalid_assignment_M]

    trait :associated_phone do
      after(:create) do |button, evaluator|
        if evaluator.phone
          button.phone = phone
        else
          button.phone = create(:phone)
        end
      end
    end

  end
end


