require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe 'Phone API endpoint' do

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

    phone1 = FactoryGirl.create(:phone, :with_buttons, venue: @venues.first)
    phone2 = FactoryGirl.create(:phone, :with_buttons, venue: @venues.second)
    phone3 = FactoryGirl.create(:phone, :with_buttons, venue: @venues.third)
    phone4 = FactoryGirl.create(:phone, :with_buttons, venue: @venues.third)
    phone5 = FactoryGirl.create(:phone, :with_buttons, venue: @venues.fourth)
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
      expect(phones.length).to be 2
      expect(phones[0][:unique_identifier]).not_to eq nil
    end
  end

  describe '#show' do
    before(:each) do
      get "/venues/#{@venues.first.id}/phones/#{@venues.first.phones.first.id}"
    end

    it 'responds successfully' do
      expect(response.status).to eq 200
    end
    it 'returns json of the phone' do
      phone = json(response.body)
      expect(phone[:unique_identifier]).not_to eq nil
      expect(phone[:unique_identifier]).to eq "#{@venues.first.id}-#{@venues.first.phones.first.id}"
      expect(phone[:venue][:id]).to eq @venues.first.id
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

  describe '#update' do

    context 'by a venue_admin' do
      before(:each) do
        patch "/venues/#{@venues.third.id}/phones/#{@venues.third.phones.first.id}",
        { phone:
          { status: 'inactive' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@venue_admin.token}"}
      end

      it 'responds with a forbidden status' do
        expect(response.status).to eq 403
      end

      it 'returns the object with successfully updated attributes' do
        body = json(response.body)
        expect(body[:error]).to eq 'You are not an admin'
      end
    end

    context 'by an Ishmael admin works too' do
      before(:each) do
        patch "/venues/#{@venues.first.id}/phones/#{@venues.first.phones.first.id}",
        { phone:
          { status: 'inactive' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@admin.token}"}
      end
      it 'responds successfully' do
        expect(response.status).to eq 200
      end
      it 'returns the object with successfully updated attributes' do
        phone = json(response.body)
        expect(phone[:status]).to eq 'inactive'
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      delete "/venues/#{@venues.third.id}/phones/#{@venues.third.phones.second.id}"
    end

    it 'responds successfully' do
      expect(response.status).to eq 204
    end
  end

  describe '#ping' do
  end

  describe '#files' do
    it 'responds successfully' do
      get "/venues/#{@venues.first.id}/phones/#{@venues.first.phones.first.id}/files"
      expect(response.status).to eq 200
      files = json(response.body)
      expect(files.length).to eq 13
    end
    it 'responds successfully' do
      get "/venues/#{@venues.third.id}/phones/#{@venues.third.phones.second.id}/files"
      expect(response.status).to eq 200
      files = json(response.body)
      expect(files.length).to eq 13
    end
  end

  describe '#log' do
    let(:log) { File.read("#{Rails.root}/spec/support/fixtures/url_encoded_log.txt") }
    let(:venue_id) { @venues.first.id }
    let(:phone_id) { @venues.first.phones.first.id }

    before(:each) do
      post "/venues/#{venue_id}/phones/#{phone_id}/log", { log: URI.unescape(log) }
    end

    it 'responds with success' do
      expect(response.status).to eq 201
    end

    it 'creates the new log and returns it as json' do
      phonelog = json(response.body)
      expect(phonelog[:log_content]).not_to eq nil
      expect(phonelog[:phone_id]).to eq phone_id
      expect(phonelog[:id]).not_to eq nil
    end
  end
end













