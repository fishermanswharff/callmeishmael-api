require 'rails_helper'

describe 'Venue API Endpoint' do
  before(:each) do
    Venue.destroy_all
    User.destroy_all
    @venue_admin = User.create({firstname: 'foo', lastname: 'bar', phonenumber: 5555555555, username: 'foobar', role: 'venue_admin', email: 'foo@bar.com', password: 'secret'})
    @venues = Venue.create([
      { name: '9 Candlewick', user: @venue_admin, number_phones: 2 },
      { name: '21 Shepard', user: @venue_admin, number_phones: 1 },
      { name: 'Strand Bookstore', user: @venue_admin, number_phones: 3 },
    ])
  end

  describe '#index' do
    before(:each) do
      get '/venues'
    end
    it 'returns a successful response' do
      expect(response.status).to eq 200
    end
    it 'returns all the venues' do
      venues = json(response.body)
      names = venues.collect { |v| v[:name] }
      expect(names).to include '9 Candlewick'
      expect(names).to include '21 Shepard'
      expect(names).to include 'Strand Bookstore'
      expect(names.length).to be 3
    end
  end

  describe '#show' do
    before(:each) do
      get "/venues/#{@venues[0].id}"
    end

    it 'returns successfully' do
      expect(response.status).to eq 200
    end
    it 'returns a single venue' do
      venue = json(response.body)
      expect(venue[:name]).to eq '9 Candlewick'
      expect(venue[:number_phones]).to eq 2
      expect(venue[:user][:username]).to eq 'foobar'
    end
  end
end