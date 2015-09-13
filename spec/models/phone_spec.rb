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

  describe '#get_urls' do

    let(:phone_with_buttons) { @venue_with_phone_and_buttons.phones.first }
    let(:filenames) { json(@venue_with_phone_and_buttons.phones.first.get_urls) }

    it 'returns an array of file urls that are assigned to the phone' do
      expect(filenames.length).to eq 13
      expect(filenames).to be_a Array
    end

    it 'returns the url of the file in order of assignment' do
      hash_button = Button.where(phone_id: phone_with_buttons.id, assignment: '#')
      post_roll_button = Button.where(phone_id: phone_with_buttons.id, assignment: 'PR')
      expect(filenames[0]).to eq hash_button.first.story.url
      expect(filenames[-1]).to eq post_roll_button.first.story.url
    end

  end

  it 'sends a log file to aws'
  # phone = @venue_with_phone_and_buttons.phones.first
  # log = FactoryGirl.create(:phonelog, phone: phone)
  # request = phone.send_log_file(log.log_content)
  # expect(request.response.status).to eq 200

end
