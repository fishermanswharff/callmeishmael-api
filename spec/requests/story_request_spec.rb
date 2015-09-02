require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe 'Stories API Endpoint' do

  before(:all) do
    @venue_admin = User.create({firstname: 'foo', lastname: 'bar', phonenumber: 5555555555, username: 'foobar', role: 'venue_admin', email: 'foo@bar.com', password: 'secret'})
    @another_venue_admin = User.create({firstname: 'baz', lastname: 'fah', phonenumber: 5555555555, username: 'bazfah', role: 'venue_admin', email: 'baz@fah.com', password: 'secret'})
    @admin = User.create({firstname: 'Logan', lastname: 'Smalley', phonenumber: 5555555555, username: 'logan', role: 'admin', email: 'logan@ted.com', password: 'secret'})
    Venue.create!([
      { name: 'The Strand' },
      { name: 'Reading Rainbow' },
      { name: 'Sesame Street' },
    ])
    @stories = Story.create!([
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
      { title: 'Gone Girl', url: 'http://callmeishmael.com', story_type: 'fixed', author_last: 'Flynn', author_first: 'Gillian' },
      { title: 'Crime And Punishment', url: 'http://callmeishmael.com', story_type: 'fixed', author_last: 'Fyodor', author_first: 'Dostoyevsky' },
      { title: 'Peter Pan', url: 'http://callmeishmael.com', story_type: 'fixed', author_last: 'Barrie', author_first: 'J. M.' },
    ])
    phones = Phone.create!([
      { wifiSSID: '78:31:c1:cd:c6:82', wifiPassword: 'secret', venue: Venue.find_by_name('The Strand') },
      { wifiSSID: '71:30:b1:bc:c4:78', wifiPassword: 'password', venue: Venue.find_by_name('The Strand') },
      { wifiSSID: '72:33:a2:ad:c2:69', wifiPassword: 'password', venue: Venue.find_by_name('Reading Rainbow') },
      { wifiSSID: '72:33:a2:ad:c2:69', wifiPassword: 'password', venue: Venue.find_by_name('Reading Rainbow') },
      { wifiSSID: '32:21:d2:bd:a1:85', wifiPassword: 'password', venue: Venue.find_by_name('Sesame Street') },
    ])
    buttons = Button.create!([
      { assignment: '*', story: Story.find_by_title('Gone Girl'), phone: phones[0] },
      { assignment: '#', story: Story.find_by_title('Crime And Punishment'), phone: phones[0] },
      { assignment: '0', story: Story.find_by_title('Peter Pan'), phone: phones[0] },
      { assignment: '*', story: Story.find_by_title('Gone Girl'), phone: phones[1] },
      { assignment: '#', story: Story.find_by_title('Crime And Punishment'), phone: phones[1] },
      { assignment: '0', story: Story.find_by_title('Peter Pan'), phone: phones[1] },
      { assignment: '*', story: Story.find_by_title('Gone Girl'), phone: phones[2] },
      { assignment: '#', story: Story.find_by_title('Crime And Punishment'), phone: phones[2] },
      { assignment: '0', story: Story.find_by_title('Peter Pan'), phone: phones[2] },
      { assignment: '1', story: Story.find_by_title('The Infernal Devices'), phone: phones[0] },
      { assignment: '2', story: Story.find_by_title('Trigger'), phone: phones[0] },
      { assignment: '3', story: Story.find_by_title('Battle Royale'), phone: phones[0] },
      { assignment: '4', story: Story.find_by_title('Looking For Alaska'), phone: phones[0] },
      { assignment: '5', story: Story.find_by_title('The Fault In Our Stars'), phone: phones[0] },
      { assignment: '6', story: Story.find_by_title('Bossy Pants'), phone: phones[0] },
      { assignment: '7', story: Story.find_by_title('A Dogs Purpose'), phone: phones[0] },
      { assignment: '8', story: Story.find_by_title('City of Bones (Mortal Instruments)'), phone: phones[0] },
      { assignment: '9', story: Story.find_by_title('Radical'), phone: phones[0] }
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
    end
  end

  describe '#show' do
    before(:each) do
      get "/stories/#{@stories[4].id}"
    end

    it 'responds successfully' do
      expect(response.status).to eq 200
    end
    it 'returns json of the phone' do
      story = json(response.body)
      expect(story[:unique_identifier]).not_to eq nil
      expect(story[:unique_identifier]).to eq "#{@stories[4].id}-1000"
      expect(story[:phones][0][:wifiSSID]).not_to be nil
      expect(story[:phones][0][:wifiSSID]).to eq '78:31:c1:cd:c6:82'
    end
  end

  describe '#create' do
    context 'with unauthorized requests' do
      before(:each) do
        post "/stories",
        { story:
          { title: 'The Enormous Room', url: 'http://callmeishmael.com', story_type: 'fixed', author_last: 'Cummings', author_first: 'e.e.' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@venue_admin.token}"}
      end
      it 'responds unauthorized' do
        expect(response.status).to eq 403
      end
      it 'responds with an error message' do
        r = json(response.body)
        expect(r[:error]).to eq 'You are not an admin'
      end
    end

    context 'with authorized request' do
      before(:each) do
        post "/stories",
        { story:
          { title: 'The Enormous Room', url: 'http://callmeishmael.com', story_type: 'fixed', author_last: 'Cummings', author_first: 'e.e.' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@admin.token}"}
      end
      it 'responds successfully' do
        expect(response.status).to eq 201
      end
      it 'responds with json object of the phone' do
        story = json(response.body)
        expect(story[:title]).to eq 'The Enormous Room'
      end
      it 'returns the location' do
        phone = json(response.body)
        expect(response.headers['Location']).to eq "http://www.example.com/stories/#{phone[:id]}"
      end
    end
  end

  describe '#update' do
    context 'by a venue_admin' do
      before(:each) do
        patch "/stories/#{@stories[-1].id}",
        { story:
          { title: 'Peter Pan', url: 'http://www.google.com', story_type: 'surprise', author_last: 'Barrie', author_first: 'J. M.' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@venue_admin.token}"}
      end

      it 'responds successfully' do
        expect(response.status).to eq 200
      end

      it 'returns the object with successfully updated attributes' do
        phone = json(response.body)
        expect(phone[:url]).to eq 'http://www.google.com'
        expect(phone[:story_type]).to eq 'surprise'
      end
    end

    context 'by an Ishmael admin works too' do
      before(:each) do
        patch "/stories/#{@stories[-1].id}",
        { story:
          { title: 'Peter Pan', url: 'http://www.google.com', story_type: 'surprise', author_last: 'Barrie', author_first: 'J. M.' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@admin.token}"}
      end
      it 'responds successfully' do
        expect(response.status).to eq 200
      end

      it 'does something else' do
        phone = json(response.body)
        expect(phone[:url]).to eq 'http://www.google.com'
        expect(phone[:story_type]).to eq 'surprise'
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      delete "/stories/#{@stories[-1].id}"
    end

    it 'responds successfully' do
      expect(response.status).to eq 204
    end

    it 'deletes the post and responds not found' do
      get "/stories/#{@stories[-1].id}"
      r = json(response.body)
      expect(r[:error]).to eq 'Record Not Found'
      expect(response.status).to eq 404
    end
  end
end
