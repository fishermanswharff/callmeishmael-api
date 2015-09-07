FactoryGirl.define do
  factory :phone do
    venue
    status 'active'
    token SecureRandom.uuid

    trait :with_buttons do
      after(:build) { |phone|
        create(:star_button, phone: phone)
        create(:hash_button, phone: phone)
        create(:zero_button, phone: phone)
        create(:one_button_with_ishmael_story, phone: phone)
        create(:two_button_with_venue_story, phone: phone)
        create(:three_button_with_ishmael_story, phone: phone)
        create(:four_button_with_ishmael_story, phone: phone)
        create(:five_button_with_ishmael_story, phone: phone)
        create(:six_button_with_venue_story, phone: phone)
        create(:seven_button_with_venue_story, phone: phone)
        create(:eight_button_with_venue_story, phone: phone)
        create(:nine_button_with_venue_story, phone: phone)
        create(:button, :postroll_story_button, phone: phone)
      }
    end
  end
end