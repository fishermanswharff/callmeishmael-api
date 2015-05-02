require 'rails_helper'

RSpec.describe 'Stories API Endpoint' do

  before(:all) do
    Story.create!([
      { title: 'The Infernal Devices', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Clare' },
      { title: 'Trigger', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Vaught' },
      { title: 'Battle Royale', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Takami' },
      { title: 'Looking For Alaska', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Green', author_first: 'John' },
      { title: 'The Fault In Our Stars', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Green', author_first: 'John' },
      { title: 'Bossy Pants', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Fey' },
      { title: 'A Dogs Purpose', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Cameron', author_first: 'Bruce' },
      { title: 'City of Bones (Mortal Instruments)', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Clare', author_first: '' },
      { title: 'Radical', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Platt', author_first: 'David' },
      { title: 'A Prayer for Owen Meany', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Irving', author_first: 'John' },
      { title: 'Speak', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Anderson', author_first: 'Laurie' },
      { title: 'If I Stay', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Forman', author_first: 'Gayle' },
      { title: 'The Perks of Being A Wallflower', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Chbosky', author_first: 'Stephen' },
      { title: 'The Great Gatsby', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Fitzgerald', author_first: 'F Scott' },
      { title: 'Eleanor & Park', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Rowell', author_first: 'Rainbow' },
      { title: 'The Spectacular Now', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Tim', author_first: 'Tharp' },
      { title: 'Feed', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Grant', author_first: 'Mira' },
      { title: 'The Alchemist', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Coelho', author_first: 'Paulo' },
      { title: 'Moby Dick', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Melville', author_first: 'Herman' },
      { title: 'Where’d You Go Bernadette', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Semple', author_first: 'Maria' },
      { title: 'Gone Girl', url: 'http://callmeishmael.com', story_type: 0, author_last: 'Flynn', author_first: 'Gillian' },
      { title: 'Crime And Punishment', url: 'http://callmeishmael.com', story_type: 0, author_last: 'Fyodor', author_first: 'Dostoyevsky' },
      { title: 'Peter Pan', url: 'http://callmeishmael.com', story_type: 0, author_last: 'Barrie', author_first: 'J. M.' },
    ])
  end

  describe '#index' do
    before(:each) do
      get '/stories'
    end

    it 'responds successfully' do
      expect(response.status).to eq 200
    end

    it 'gives back all of the stories' do
      stories = json(response.body)
      expect(stories.length).not_to be nil
      p stories
    end
  end

  describe '#show' do
    before(:each) do
      get "/stories/#{@stories[0].id}"
    end
  end
end