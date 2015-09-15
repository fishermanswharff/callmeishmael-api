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

  before(:all) do
    Button.destroy_all
    Phone.destroy_all
    Story.destroy_all
    @phone = FactoryGirl.create(:phone, status: 'active')
    @star_button = FactoryGirl.create(:star_button, phone: @phone)
    @hash_button = FactoryGirl.create(:hash_button, phone: @phone)
    @zero_button = FactoryGirl.create(:zero_button, phone: @phone)
    @one_button = FactoryGirl.create(:one_button_with_ishmael_story, phone: @phone)
    @two_button = FactoryGirl.create(:two_button_with_ishmael_story, phone: @phone)
    @three_button = FactoryGirl.create(:three_button_with_ishmael_story, phone: @phone)
    @four_button = FactoryGirl.create(:four_button_with_ishmael_story, phone: @phone)
    @five_button = FactoryGirl.create(:five_button_with_ishmael_story, phone: @phone)
    @six_button = FactoryGirl.create(:six_button_with_ishmael_story, phone: @phone)
    @seven_button = FactoryGirl.create(:seven_button_with_ishmael_story, phone: @phone)
    @eight_button = FactoryGirl.create(:eight_button_with_ishmael_story, phone: @phone)
    @nine_button = FactoryGirl.create(:nine_button_with_ishmael_story, phone: @phone)
    @postroll_button = FactoryGirl.create(:postroll, phone: @phone)
    @invalid_button = FactoryGirl.build(:invalid_button_ß)
    @phones = FactoryGirl.create_list(:phone, 14, :with_buttons)
    @valid_assignments = Button::VALID_PLACEMENTS
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

  it 'is invalid if a button with the same assignment already exists' do
    @phone.reload
    new_button = FactoryGirl.build(:star_button, phone: @phone)
    expect(new_button).not_to be_valid
    expect { new_button.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'allows you to update the story on the assignment' do
    new_story = FactoryGirl.create(:story, :ishmaels_story, :male_caller, :explicit)
    @nine_button.update(story: new_story)
    expect(@nine_button.story).to eq new_story
  end

  it 'removes the assignment from a button if an assignment is being updated' do
    phone = @phones.first.reload
    button_to_reassign = phone.buttons.fourth
    old_button = phone.buttons.detect { |button| button.assignment == '5' }

    expect(old_button.assignment).to eq '5'
    expect(button_to_reassign.assignment).to eq '1'

    button_to_reassign.update(assignment: '5')
    phone.reload

    expect(button_to_reassign.assignment).to eq '5'
    expect(old_button.assignment).to eq 'none'
  end

  it 'returns postroll assigned buttons' do
    postroll_buttons = Button.postroll_assignments
    expect(postroll_buttons.length).to eq 15
    expect(postroll_buttons.first).to eq @postroll_button
  end

  it 'returns fixed assigned buttons' do
    fixed = Button.fixed_assignments
    expect(fixed.length).to eq (@phones.length * 3) + 3 #@phones.length * 3 fixed buttons per phone, + the 3 created above
  end

  it 'updates the story of a postroll assignment' do
    postrolls = Button.postroll_assignments
    story = postrolls.last.story
    Button.assign_story_by_assignment(story, 'PR')
    expect(Button.postroll_assignments).to all(have_attributes(story_id: story.id))
  end

  it 'updates the story of a star assignment' do
    stars = Button.star_assignments
    story = FactoryGirl.create(:story, :fixed_story, :male_caller, :explicit, :spoiler_alert, :not_appropriate_for_children)

    expect(stars.first.story).not_to eq story
    expect(stars.second.story).not_to eq story

    Button.assign_story_by_assignment(story, '*')

    expect(Button.star_assignments).to all(have_attributes(story_id: story.id))
  end


end
