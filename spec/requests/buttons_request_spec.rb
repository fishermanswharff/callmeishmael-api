require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe 'Buttons API Endpoint (Phone and Story Join Table)' do

  before(:all) do
    @venue_admin = User.create({firstname: 'foo', lastname: 'bar', phonenumber: 5555555555, username: 'foobar', role: 'venue_admin', email: 'foo@bar.com', password: 'secret'})
    @another_venue_admin = User.create({firstname: 'baz', lastname: 'fah', phonenumber: 5555555555, username: 'bazfah', role: 'venue_admin', email: 'baz@fah.com', password: 'secret'})
    @admin = User.create({firstname: 'Logan', lastname: 'Smalley', phonenumber: 5555555555, username: 'logan', role: 'admin', email: 'logan@ted.com', password: 'secret'})
    @venues = FactoryGirl.create_list(:venue, 4)
    @ishmaels_stories = FactoryGirl.create_list(:story, 281, :ishmaels_story)
    @venues.first.stories = FactoryGirl.create_list(:story_associated_with_venue, 47, venues: [@venues.first])
    @venues.second.stories = FactoryGirl.create_list(:story_associated_with_venue, 24, venues: [@venues.second])
    @fixed_stories = FactoryGirl.create_list(:story, 9, :fixed_story)
    @postroll_stories = FactoryGirl.create_list(:story, 8, :postroll_story)

    @phone1 = FactoryGirl.create(:phone, :with_buttons, venue: @venues.first)
    @phone2 = FactoryGirl.create(:phone, :with_buttons, venue: @venues.second)
    @phone3 = FactoryGirl.create(:phone, :with_buttons, venue: @venues.third)
    @phone4 = FactoryGirl.create(:phone, :with_buttons, venue: @venues.third)
    @phone5 = FactoryGirl.create(:phone, venue: @venues.fourth)
  end

  describe '#create' do
    before(:each) do
      button = FactoryGirl.build(:star_button, phone: @phone5)
      post '/buttons',
      { button: button }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@another_venue_admin.token}"}
    end
    it 'responds 201:created' do
      expect(response.status).to eq 201
    end
    it 'responds with the newly created association' do
      button = json(response.body)
      expect(button[:assignment]).to eq '*'
      expect(button[:story][:story_type]).to eq 'fixed'
    end
  end

  describe '#update' do

    before(:each) do
      patch "/buttons/#{Button.where(phone_id: @phone1.id)[3].id}",
      { button:
        { assignment: '5' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@another_venue_admin.token}"}
    end

    it 'responds successfully' do
      expect(response.status).to eq 200
    end

    it 'returns the object with successfully updated attributes' do
      button = json(response.body)
      expect(button[:assignment]).to eq '5'
    end
  end
end
