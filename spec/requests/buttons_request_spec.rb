require 'rails_helper'

describe 'Buttons API Endpoint (Phone and Story Join Table)' do

  before(:all) do
    @another_venue_admin = User.create({firstname: 'baz', lastname: 'fah', phonenumber: 5555555555, username: 'bazfah', role: 'venue_admin', email: 'baz@fah.com', password: 'secret'})
    @admin = User.create({firstname: 'Logan', lastname: 'Smalley', phonenumber: 5555555555, username: 'logan', role: 'admin', email: 'logan@ted.com', password: 'secret'})
    @venues = Venue.create!([
      { name: 'The Strand' },
      { name: 'Reading Rainbow' },
      { name: 'Sesame Street' },
    ])
    @stories = Story.create!([
      { title: 'The Infernal Devices', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Clare' },
      { title: 'Bossy Pants', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Fey' },
      { title: 'A Dogs Purpose', url: 'http://callmeishmael.com', story_type: 'venue', author_last: 'Cameron', author_first: 'Bruce' },
      { title: 'Gone Girl', url: 'http://callmeishmael.com', story_type: 'fixed', author_last: 'Flynn', author_first: 'Gillian' },
      { title: 'Crime And Punishment', url: 'http://callmeishmael.com', story_type: 'fixed', author_last: 'Fyodor', author_first: 'Dostoyevsky' },
    ])
    @phones = Phone.create!([
      { wifiSSID: '78:31:c1:cd:c6:82', wifiPassword: 'secret', venue: Venue.find_by_name('The Strand') },
      { wifiSSID: '71:30:b1:bc:c4:78', wifiPassword: 'password', venue: Venue.find_by_name('The Strand') },
      { wifiSSID: '72:33:a2:ad:c2:69', wifiPassword: 'password', venue: Venue.find_by_name('Reading Rainbow') },
      { wifiSSID: '72:33:a2:ad:c2:69', wifiPassword: 'password', venue: Venue.find_by_name('Reading Rainbow') },
      { wifiSSID: '32:21:d2:bd:a1:85', wifiPassword: 'password', venue: Venue.find_by_name('Sesame Street') },
    ])
  end

  describe '#create' do
    before(:each) do
      post "/buttons",
      { button:
        { assignment: '3', phone_id: @phones[0].id , story_id: @stories[-1].id }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@another_venue_admin.token}"}
    end
    it 'responds 201:created' do
      expect(response.status).to eq 201
    end
    it 'responds with the newly created association' do
      button = json(response.body)
      expect(button[:assignment]).to eq '3'
      expect(button[:phone][:wifiSSID]).to eq '78:31:c1:cd:c6:82'
      expect(button[:story][:title]).to eq 'Crime And Punishment'
    end
  end

  describe '#update' do

    before(:all) do
      @button = Button.create!({ assignment: '9', phone: @phones[-1], story: @stories[-2]} )
    end

    before(:each) do
      patch "/buttons/#{@button.id}",
      { button:
        { assignment: '5' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@another_venue_admin.token}"}
    end

    it 'responds successfully' do
      expect(response.status).to eq 200
    end

    it 'returns the object with successfully updated attributes' do
      phone = json(response.body)
      expect(phone[:assignment]).to eq '5'
    end
  end




end