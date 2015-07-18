require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe Story, type: :model do

  before(:all) do
    Story.destroy_all
    @stories = Story.create!([
      { title: 'The Infernal Devices', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Clare' },
      { title: 'Trigger', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Vaught' },
      { title: 'Battle Royale', url: 'http://callmeishmael.com', story_type: 'surprise', author_last: 'Takami' },
      { title: 'Looking For Alaska', url: 'http://callmeishmael.com', story_type: 'fixed', author_last: 'Green', author_first: 'John' },
    ])
  end

  it 'is a story' do
    expect(@stories[0]).to be_a Story
    expect(@stories[1]).to be_a Story
    expect(@stories[2]).to be_a Story
    expect(@stories[3]).to be_a Story
  end

  it 'has a title' do
    expect(@stories[0].title).to eq 'The Infernal Devices'
  end

  it 'has a url' do
    expect(@stories[1].url).to eq 'http://callmeishmael.com'
  end

  it 'has a story_type' do
    expect(@stories[2].story_type).to eq 'surprise'
  end

  it 'has a unique identifier' do
    expect(@stories[3].unique_identifier).to eq '7-1000'
  end
end