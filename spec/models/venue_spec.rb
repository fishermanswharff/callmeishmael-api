require 'rails_helper'

RSpec.describe Venue, type: :model do

  before(:each) do
    Venue.destroy_all
    User.destroy_all
    @venue_admin = User.create({firstname: 'foo', lastname: 'bar', phonenumber: 5555555555, username: 'foobar', role: 'venue_admin', email: 'foo@bar.com', password: 'secret'})
    @venue = Venue.create({
      name: '9 Candlewick',
      number_phones: 2
    })
    @venue.users << @venue_admin
  end

  it 'has a name' do
    expect(@venue.name).to eq '9 Candlewick'
  end

  it 'has a unique_identifier' do
    expect(@venue.unique_identifier).to eq "#{@venue.id}-1000"
  end

  it 'has a default status of true' do
    expect(@venue.status).to eq true
  end

  it 'has a count of number of phones at the venue' do
    expect(@venue.number_phones).to eq 2
  end

  it 'has many users' do
    expect(@venue.users.first).to eq @venue_admin
  end

end