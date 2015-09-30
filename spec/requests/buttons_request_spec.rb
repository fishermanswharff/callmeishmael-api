require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe 'Buttons API Endpoint (Phone and Story Join Table)' do

  before(:all) do

    Venue.destroy_all
    Phone.destroy_all
    Button.destroy_all
    Story.destroy_all
    User.destroy_all

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

    context 'when a button assignment already exists' do
      before(:all) do
        @new_button = FactoryGirl.attributes_for(:star_button).merge(phone_id: @phone4.id, story_id: @ishmaels_stories.first.id)
      end

      it 'throws an error because there is already a button with that assignment' do
        expect {
          post '/buttons',
          { button: @new_button }.to_json,
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@another_venue_admin.token}"}
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when it is a new button' do
      before(:all) do
        new_phone = FactoryGirl.create(:phone, venue: FactoryGirl.create(:venue))
        new_button = FactoryGirl.attributes_for(:star_button).merge(phone_id: new_phone.id, story_id: @fixed_stories.first.id)
        post '/buttons',
        { button: new_button }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@another_venue_admin.token}"}
      end

      it 'responds 201' do
        expect(response.status).to eq 201
      end

      it 'responds with the newly created association' do
        button = json(response.body)
        expect(button[:assignment]).to eq '*'
        expect(button[:story][:story_type]).to eq 'fixed'
      end
    end
  end

  describe '#update' do

    context 'assigning buttons 1–9' do
      before(:all) do
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

  describe '#update_fixed' do
    context 'assigning buttons 0,*,#, & PR' do
      before(:all) do
        post "/buttons/update_fixed",
        { button:
          { assignment: '*', story_id: @ishmaels_stories.first.id }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@another_venue_admin.token}"}
      end
      it 'returns json of all the buttons with the assignment' do
        body = json(response.body)
        expect(body).not_to eq nil
        expect(body.length).to be > 0
        expect(body.length).to eq 5
      end
      it 'returns json representing the assignment on all of the phones' do
        body = json(response.body)
        expect(body.first[:assignment]).to eq '*'
        expect(body.second[:assignment]).to eq '*'
      end
    end
  end
end
