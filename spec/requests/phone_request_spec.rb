require 'rails_helper'

describe 'Phone API endpoint' do

  before(:all) do
    Venue.destroy_all
    Phone.destroy_all
    User.destroy_all
    @venue_admin = User.create({firstname: 'foo', lastname: 'bar', phonenumber: 5555555555, username: 'foobar', role: 'venue_admin', email: 'foo@bar.com', password: 'secret'})
    @another_venue_admin = User.create({firstname: 'baz', lastname: 'fah', phonenumber: 5555555555, username: 'bazfah', role: 'venue_admin', email: 'baz@fah.com', password: 'secret'})
    @admin = User.create({firstname: 'Logan', lastname: 'Smalley', phonenumber: 5555555555, username: 'logan', role: 'admin', email: 'logan@ted.com', password: 'secret'})
    @venues = Venue.create([
      { name: '9 Candlewick', user: @venue_admin },
      { name: '21 Shepard', user: @venue_admin },
      { name: 'Strand Bookstore', user: @venue_admin },
    ])

    @phones = Phone.create([
      { wifiSSID: '78:31:c1:cd:c6:82', wifiPassword: 'secret', venue: @venues[0]},
      { wifiSSID: '79:30:b1:bc:c4:78', wifiPassword: 'password', venue: @venues[0]},
      { wifiSSID: '77:30:b1:bc:c4:78', wifiPassword: 'password', venue: @venues[0]},
      { wifiSSID: '76:30:b1:bc:c4:78', wifiPassword: 'password', venue: @venues[1]},
      { wifiSSID: '75:30:b1:bc:c4:78', wifiPassword: 'password', venue: @venues[1]},
      { wifiSSID: '74:30:b1:bc:c4:78', wifiPassword: 'password', venue: @venues[2]},
      { wifiSSID: '73:30:b1:bc:c4:78', wifiPassword: 'password', venue: @venues[2]},
      { wifiSSID: '72:30:b1:bc:c4:78', wifiPassword: 'password', venue: @venues[2]},
      { wifiSSID: '71:30:b1:bc:c4:78', wifiPassword: 'password', venue: @venues[2]},
    ])
  end

  describe '#index' do
    before(:each) do
      get "/venues/#{@venues[2].id}/phones"
    end

    it 'responsds successfully' do
      expect(response.status).to eq 200
    end
    it 'returns json of phones at a single venue' do
      phones = json(response.body)
      expect(phones.length).to be 4
      expect(phones[0][:unique_identifier]).not_to eq nil
    end
  end
end