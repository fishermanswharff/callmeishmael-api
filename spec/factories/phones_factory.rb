FactoryGirl.define do
  factory :phone do
    venue
    token SecureRandom.uuid

    trait :with_buttons do
      after(:build) { |phone|
        Button.create!([
          { assignment: '*', story: FactoryGirl.create(:story, :fixed_story), phone: phone},
          { assignment: '#', story: FactoryGirl.create(:story, :fixed_story), phone: phone},
          { assignment: '0', story: FactoryGirl.create(:story, :fixed_story), phone: phone},
          { assignment: '1', story: FactoryGirl.create(:story, :ishmaels_story), phone: phone},
          { assignment: '2', story: FactoryGirl.create(:story, :ishmaels_story), phone: phone},
          { assignment: '3', story: FactoryGirl.create(:story, :ishmaels_story), phone: phone},
          { assignment: '4', story: FactoryGirl.create(:story, :ishmaels_story), phone: phone},
          { assignment: '5', story: FactoryGirl.create(:story, :ishmaels_story), phone: phone},
          { assignment: '6', story: FactoryGirl.create(:story, :ishmaels_story), phone: phone},
          { assignment: '7', story: FactoryGirl.create(:story, :ishmaels_story), phone: phone},
          { assignment: '8', story: FactoryGirl.create(:story, :ishmaels_story), phone: phone},
          { assignment: '9', story: FactoryGirl.create(:story, :ishmaels_story), phone: phone},
          { assignment: 'PR', story: FactoryGirl.create(:story, :postroll_story), phone: phone},
        ])
      }
    end

    factory :with_button, traits: [:with_buttons]
  end
end