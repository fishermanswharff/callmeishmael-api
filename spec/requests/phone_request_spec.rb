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

  describe '#show' do
    before(:each) do
      get "/venues/#{@venues[1].id}/phones/#{@phones[4].id}"
    end

    it 'responds successfully' do
      expect(response.status).to eq 200
    end
    it 'returns json of the phone' do
      phone = json(response.body)
      expect(phone[:unique_identifier]).not_to eq nil
      expect(phone[:unique_identifier]).to eq "#{@venues[1].id}-#{@phones[4].id}"
      expect(phone[:venue][:id]).to eq @venues[1].id
    end
  end

  describe '#create' do

    context 'with unauthorized requests' do
      before(:each) do
        post "/venues/#{@venues[2].id}/phones",
        { phone:
          { wifiSSID: '70:20:a1:ac:b3:69', wifiPassword: '123456' }
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
        post "/venues/#{@venues[2].id}/phones",
        { phone:
          { wifiSSID: '70:20:a1:ac:b3:69', wifiPassword: '123456' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@admin.token}"}
      end

      it 'responds successfully' do
        expect(response.status).to eq 201
      end
      it 'responds with json object of the phone' do
        phone = json(response.body)
        expect(phone[:unique_identifier]).to eq "#{@venues[2].id}-#{phone[:id]}"
      end
      it 'returns the location' do
        phone = json(response.body)
        expect(response.headers['Location']).to eq "http://www.example.com/venues/#{@venues[2].id}/phones/#{phone[:id]}"
      end
    end
  end
end


















