require 'rails_helper'

describe Phone, type: :model do

  before(:all) do
    Venue.destroy_all
    Phone.destroy_all
    User.destroy_all
    @venue_admin = User.create({firstname: 'foo', lastname: 'bar', phonenumber: 5555555555, username: 'foobar', role: 'venue_admin', email: 'foo@bar.com', password: 'secret'})
    @venue = Venue.create({
      name: '9 Candlewick',
      user: @venue_admin
    })
    @phones = Phone.create([
      { wifiSSID: '78:31:c1:cd:c6:82', wifiPassword: 'secret', venue: @venue},
      { wifiSSID: '79:30:b1:bc:c4:78', wifiPassword: 'password', venue: @venue},
    ])
  end

  it 'is a phone' do
    expect(@phones[0].class).to be Phone
    expect(@phones[1].class).to be Phone
  end

  it 'belongs to a venue' do
    expect(@phones[0].venue).to be @venue
    expect(@phones[1].venue).to be @venue
  end

  it 'has a unique id generated from the venue id and the phone id' do
    expect(@phones[0].unique_identifier).to eq "#{@venue.id}-#{@phones[0].id}"
    expect(@phones[1].unique_identifier).to eq "#{@venue.id}-#{@phones[1].id}"
  end

end