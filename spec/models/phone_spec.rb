# == Schema Information
#
# Table name: phones
#
#  id                :integer          not null, primary key
#  unique_identifier :text
#  token             :text             not null
#  status            :integer          default(0), not null
#  wifiSSID          :text
#  wifiPassword      :text
#  created_at        :datetime
#  updated_at        :datetime
#  venue_id          :integer
#

require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Phone, type: :model do

  before(:all) do
    Venue.destroy_all
    Phone.destroy_all
    @venue_admin = User.create({firstname: 'foo', lastname: 'bar', phonenumber: 5555555555, username: 'foobar', role: 'venue_admin', email: 'foo@bar.com', password: 'secret'})
    @venue_with_phone = FactoryGirl.create(:venue_with_phone, number_phones: 2)
    @venue_with_phone_and_buttons = FactoryGirl.create(:venue_with_phone_and_buttons, number_phones: 4)
    @phone = FactoryGirl.create(:phone, status: 'active')
  end

  it 'is a phone' do
    expect(@phone.class).to be Phone
    expect(@phone).to be_a Phone
    expect(@venue_with_phone.phones.first.class).to be Phone
  end

  it 'belongs to a venue' do
    expect(@phone.venue).to be_a Venue
  end

  it 'has a unique id generated from the venue id and the nth phone on that venue' do
    @phone.venue.reload
    @venue_with_phone.reload
    @venue_with_phone_and_buttons.reload
    expect(@phone.unique_identifier).to eq "#{@phone.venue.id}-1"
    expect(@venue_with_phone.phones.first.unique_identifier).to eq "#{@venue_with_phone.id}-1"
    expect(@venue_with_phone.phones.second.unique_identifier).to eq "#{@venue_with_phone.id}-2"
    expect(@venue_with_phone_and_buttons.phones.first.unique_identifier).to eq "#{@venue_with_phone_and_buttons.id}-1"
    expect(@venue_with_phone_and_buttons.phones.second.unique_identifier).to eq "#{@venue_with_phone_and_buttons.id}-2"
    expect(@venue_with_phone_and_buttons.phones.third.unique_identifier).to eq "#{@venue_with_phone_and_buttons.id}-3"
    expect(@venue_with_phone_and_buttons.phones.fourth.unique_identifier).to eq "#{@venue_with_phone_and_buttons.id}-4"
  end

  it 'returns an array of urls that point to the files on the phone' do
    phone = @venue_with_phone_and_buttons.phones.first
    phone2 = @venue_with_phone_and_buttons.phones.second
    phone3 = @venue_with_phone_and_buttons.phones.third
    phone4 = @venue_with_phone_and_buttons.phones.fourth
    json1 = json(phone.get_urls)
    json2 = json(phone2.get_urls)
    json3 = json(phone3.get_urls)
    json4 = json(phone4.get_urls)
    expect(json1.length).to eq 13
    expect(json2.length).to eq 13
    expect(json3.length).to eq 13
    expect(json4.length).to eq 13
  end

  it 'sends a log file to aws'
  # phone = @venue_with_phone_and_buttons.phones.first
  # log = FactoryGirl.create(:phonelog, phone: phone)
  # request = phone.send_log_file(log.log_content)
  # expect(request.response.status).to eq 200

end
