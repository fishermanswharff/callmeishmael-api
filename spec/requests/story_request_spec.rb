require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe 'Stories API Endpoint', type: :request do

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
  end

  describe '#index' do
    before(:all) do
      get '/stories'
    end

    it 'responds successfully' do
      expect(response.status).to eq 200
    end

    it 'gives back all of the stories' do
      expect(response).not_to be nil
      stories = json(response.body)
      expect(stories.length).to eq @ishmaels_stories.length + @fixed_stories.length + @postroll_stories.length + @venues.first.stories.length + @venues.second.stories.length
    end
  end

  describe '#show' do
    before(:each) do
      get "/stories/#{@ishmaels_stories.fourth.id}"
    end

    it 'responds successfully' do
      expect(response.status).to eq 200
    end
    it 'returns json of the phone' do
      story = json(response.body)
      expect(story[:unique_identifier]).not_to eq nil
    end
  end

  describe '#create' do
    context 'with unauthorized requests' do
      before(:each) do
        story = FactoryGirl.attributes_for(:story, :ishmaels_story, :male_caller, :explicit, :spoiler_alert)
        post "/stories",
        { story: story }.to_json,
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
        story = FactoryGirl.attributes_for(:story, :ishmaels_story, :male_caller, :explicit, :spoiler_alert)
        post "/stories",
        { story: story }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@admin.token}"}
      end
      it 'responds successfully' do
        expect(response.status).to eq 201
      end
      it 'responds with json object of the story' do
        story = json(response.body)
        expect(story[:title]).to be_a String
        expect(story[:title]).not_to eq nil
      end
      it 'returns the location' do
        story = json(response.body)
        expect(response.headers['Location']).to eq "http://www.example.com/stories/#{story[:id]}"
      end
    end

  describe '#update' do
    context 'by a venue_admin' do
      before(:each) do
        patch "/stories/#{@ishmaels_stories[-1].id}",
        { story:
          { title: 'Peter Pan', url: 'http://www.google.com', explicit: true, child_apprpriate: false, spoiler_alert: true, story_type: 'postroll', author_last: 'Barrie', author_first: 'J. M.' }
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
        patch "/stories/#{@ishmaels_stories[-1].id}",
        { story:
          { title: 'Peter Pan', url: 'http://www.google.com', explicit: true, child_apprpriate: false, spoiler_alert: true, story_type: 'postroll', author_last: 'Barrie', author_first: 'J. M.' }
        }.to_json,
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@admin.token}"}
      end
      it 'responds successfully' do
        expect(response.status).to eq 200
      end

      it 'does something else' do
        story = json(response.body)
        expect(story[:url]).to eq 'http://www.google.com'
        expect(story[:story_type]).to eq 'postroll'
        expect(story[:explicit]).to eq true
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      delete "/stories/#{@ishmaels_stories[-1].id}"
    end

    it 'responds successfully' do
      expect(response.status).to eq 204
    end

    it 'deletes the post and responds not found' do
      get "/stories/#{@ishmaels_stories[-1].id}"
      r = json(response.body)
      expect(r[:error]).to eq 'Record Not Found'
      expect(response.status).to eq 404
    end
  end

  describe '#story_data' do
    before(:all) do
      get '/stories/story_data'
    end
    it 'returns storyData as well' do
      expect(response).not_to eq nil
      data = json(response.body)
      expect(data[:number_ishmael_stories]).to eq @ishmaels_stories.count
      expect(data[:number_venue_stories]).to eq @venues.first.stories.count + @venues.second.stories.count
    end
  end
end
