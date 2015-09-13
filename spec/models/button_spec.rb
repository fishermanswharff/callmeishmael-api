# == Schema Information
#
# Table name: buttons
#
#  id         :integer          not null, primary key
#  assignment :text             not null
#  phone_id   :integer
#  story_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Button, type: :model do

  before(:each) do
    @phone = FactoryGirl.create(:phone, status: 'active')
    @star_button = FactoryGirl.create(:star_button)
    @hash_button = FactoryGirl.create(:hash_button)
    @zero_button = FactoryGirl.create(:zero_button)
    @one_button = FactoryGirl.create(:one_button_with_ishmael_story)
    @two_button = FactoryGirl.create(:two_button_with_ishmael_story)
    @three_button = FactoryGirl.create(:three_button_with_ishmael_story)
    @four_button = FactoryGirl.create(:four_button_with_ishmael_story)
    @five_button = FactoryGirl.create(:five_button_with_ishmael_story)
    @six_button = FactoryGirl.create(:six_button_with_ishmael_story)
    @seven_button = FactoryGirl.create(:seven_button_with_ishmael_story)
    @eight_button = FactoryGirl.create(:eight_button_with_ishmael_story)
    @nine_button = FactoryGirl.create(:nine_button_with_ishmael_story)

    @invalid_button = FactoryGirl.build(:invalid_button_ß)

    @valid_assignments = ['*','#','0','1','2','3','4','5','6','7','8','9','PR']
  end

  it 'is of the button class' do
    expect(@star_button).to be_a Button
    expect(@six_button).to be_a Button
  end

  it 'is associated with a phone and a story' do
    expect(@star_button.phone).to be_a Phone
  end

  it 'has a valid assignment' do
    expect(@valid_assignments).to include @star_button.assignment
  end

  it 'is invalid with an incorrect assignment' do
    expect(@valid_assignments).not_to include @invalid_button.assignment
  end

  it 'returns invalid with an incorrect assignment' do
    expect(@invalid_button.valid?).to eq false
  end


end