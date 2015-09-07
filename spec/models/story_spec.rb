# == Schema Information
#
# Table name: stories
#
#  id                :integer          not null, primary key
#  unique_identifier :text
#  title             :text             not null
#  url               :text             not null
#  story_type        :integer          default(1), not null
#  author_last       :text
#  author_first      :text
#  placements        :integer          default(0), not null
#  listens           :integer          default(0), not null
#  percentage        :decimal(4, 2)
#  created_at        :datetime
#  updated_at        :datetime
#  call_length       :string
#  common_title      :string
#  call_date         :date
#  spoiler_alert     :boolean          default(FALSE), not null
#  child_appropriate :boolean          default(TRUE), not null
#  explicit          :boolean          default(FALSE), not null
#  gender            :string           default("Female"), not null
#  rating            :integer          default(1), not null
#

require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe Story, type: :model do

  before(:all) do
    Story.delete_all
    Venuestory.delete_all

    @stories = [
      FactoryGirl.create(:story, :venue_story, :associated_venue),
      FactoryGirl.create(:story, :ishmaels_story),
      FactoryGirl.create(:story, :postroll_story),
      FactoryGirl.create(:story, :fixed_story),
      FactoryGirl.create(:story, :venue_story, :associated_venue, :male_caller, :explicit, :spoiler_alert, :not_appropriate_for_children)
    ]
  end

  it 'is a story' do
    expect(@stories[0]).to be_a Story
    expect(@stories[1]).to be_a Story
    expect(@stories[2]).to be_a Story
    expect(@stories[3]).to be_a Story
    expect(@stories[4]).to be_a Story
  end

  it 'has a title' do
    expect(@stories.first.title).not_to eq nil
    expect(@stories.first.title).to be_a String
  end

  it 'has a url' do
    match = @stories.first.url.match(/s3-us-west-2.amazonaws.com/)
    expect(match.present?).to eq true
    expect(match.blank?).to eq false
    expect(match.to_a[0]).to eq 's3-us-west-2.amazonaws.com'
    expect(match.pre_match).to eq 'http://'
  end

  it 'has a story_type' do
    expect(@stories.last.story_type).to eq 'venue'
    expect(@stories.first.story_type).to eq 'venue'
    expect(@stories.second.story_type).to eq 'ishmaels'
    expect(@stories.third.story_type).to eq 'postroll'
    expect(@stories.fourth.story_type).to eq 'fixed'
  end

  it 'can be flagged inappropriate for children' do
    expect(@stories.last.child_appropriate).to eq false
  end

  it 'is invalid if the date is in the future' do
    @stories.first.call_date = Date.tomorrow
    expect(@stories.first.valid?).to eq false
  end

end
