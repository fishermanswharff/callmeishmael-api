# == Schema Information
#
# Table name: venuestories
#
#  id         :integer          not null, primary key
#  venue_id   :integer
#  story_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe Venuestory, type: :model do

  before(:each) do
    Venuestory.destroy_all
    Venue.destroy_all
    Story.destroy_all
    @the_strand = FactoryGirl.create(:venue)
    @reading_rainbow = FactoryGirl.create(:venue)
    @the_strand.stories = FactoryGirl.create_list(:story_associated_with_venue, 56, venues: [@the_strand])
    @reading_rainbow.stories = FactoryGirl.create_list(:story_associated_with_venue, 39, venues: [@reading_rainbow])
    @ishmaelsstories = FactoryGirl.create_list(:story, 287, :ishmaels_story)
  end

  it 'is a join between venue and story, or a venuestory model type' do
    stories = @the_strand.stories
    expect(stories[0]).to be_a Story
    expect(stories.first.venues.first).to be_a Venue
  end

  it 'has a list of stories assigned to a venue' do
    stories = Story.all
    expect(@the_strand.stories.length).to eq 56
    expect(@reading_rainbow.stories.length).to eq 39
    expect(stories.length).to eq @the_strand.stories.length + @reading_rainbow.stories.length + @ishmaelsstories.length
  end

end
