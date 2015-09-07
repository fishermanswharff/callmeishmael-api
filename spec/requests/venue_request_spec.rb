require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe 'Venue API Endpoint' do
  before(:all) do
    Venuestory.destroy_all
    Venue.destroy_all
    Story.destroy_all
    User.destroy_all
    @venue_admin = User.create({firstname: 'foo', lastname: 'bar', phonenumber: 5555555555, username: 'foobar', role: 'venue_admin', email: 'foo@bar.com', password: 'secret'})
    @another_venue_admin = User.create({firstname: 'baz', lastname: 'fah', phonenumber: 5555555555, username: 'bazfah', role: 'venue_admin', email: 'baz@fah.com', password: 'secret'})
    @admin = User.create({firstname: 'Logan', lastname: 'Smalley', phonenumber: 5555555555, username: 'logan', role: 'admin', email: 'logan@ted.com', password: 'secret'})
    @reading_rainbow = FactoryGirl.create(:venue, name: 'Reading Rainbow')
    @reading_rainbow.stories = FactoryGirl.create_list(:story_associated_with_venue, 284, venues: [@reading_rainbow])
    @venues = [
      FactoryGirl.create(:venue_with_phone_and_buttons, number_phones: 2, name: '9 Candlewick'),
      FactoryGirl.create(:venue_with_phone_and_buttons, name: '21 Shepard'),
      FactoryGirl.create(:venue_with_stories, story_count: 43, name: 'Strand Bookstore'),
    ]
    @story = FactoryGirl.create(:story, :fixed_story, title: 'On Looking', url: 'https://s3-us-west-2.amazonaws.com/callmeishmael-files/699-On-Looking-by-Alexandra-Horowitz-final.ogg' )
    @venues.first.users << @venue_admin
    @venues.first.users << @another_venue_admin
    @venues.first.users << @admin
    @venues.second.users << @another_venue_admin
    @venues.third.users << @venue_admin
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
      expect(names.length).to be 4
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
      expect(venue[:users][0][:username]).to eq 'foobar'
    end
  end

  describe '#show with venue stories' do
    before(:each) do
      get "/venues/#{@reading_rainbow.id}"
    end

    it 'returns successfully' do
      expect(response.status).to eq 200
    end

    it 'returns a single venue' do
      venue = json(response.body)
      expect(venue[:name]).to_not be nil
    end

    it 'has a list of stories associated with the venue' do
      venue = json(response.body)
      expect(venue[:stories].length).to be 284
    end
  end

  describe '#create' do

    context 'without an admin user’s authorization' do
      before(:each) do
        post '/venues',
        { venue:
          { name: 'Harvard Book Store', user_ids: "#{@venue_admin.id}", number_phones: 1 }
        }.to_json,
        {
          'Accept' => Mime::JSON,
          'Content-Type' => Mime::JSON.to_s,
          'HTTP_AUTHORIZATION' => "Token token=#{@venue_admin.token}"
        }
      end
      it 'responds unauthorized' do
        expect(response.status).to eq 403
        r = json(response.body)
        expect(r[:error]).to eq 'You are not an admin'
      end
    end

    context 'with an admin user’s authorization' do
      before(:each) do
        post '/venues',
        { venue:
          { name: 'Harvard Book Store', user_ids: [@venue_admin.id, @another_venue_admin.id], number_phones: 1 }
        }.to_json,
        {
          'Accept' => Mime::JSON,
          'Content-Type' => Mime::JSON.to_s,
          'HTTP_AUTHORIZATION' => "Token token=#{@admin.token}"
        }
      end

      it 'responds successfully' do
        expect(response.status).to eq 201
      end
      it 'returns the newly created venue with the user' do
        venue = json(response.body)
        expect(venue[:users][0][:firstname]).to eq 'foo'
        expect(venue[:users][1][:firstname]).to eq 'baz'
        expect(venue[:users].length).to eq 2
      end
    end
  end

  describe '#update' do
    before(:each) do
      patch "/venues/#{@venues[2].id}",
      { venue:
        {
          name: 'Strand Bookstore on 5th Avenue',
          number_phones: 3,
          user_id: "#{@another_venue_admin.id}",
          story_id: "#{@story.id}"
        }
      }.to_json,
      {
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s,
        'HTTP_AUTHORIZATION' => "Token token=#{@venue_admin.token}"
      }
    end
    it 'responds successfully' do
      expect(response.status).to eq 200
    end
    it 'updates only the changed attributes of the venue' do
      venue = json(response.body)
      expect(venue[:users].last[:id]).to eq "#{@another_venue_admin.id}"
      expect(venue[:name]).to eq 'Strand Bookstore on 5th Avenue'
      expect(venue[:number_phones]).to eq 3
    end
    it 'has stories attached to the venue' do
      venue = json(response.body)
      expect(venue[:stories].count).to eq 44
    end
  end

  describe '#destroy' do
    before(:each) do
      delete "/venues/#{@venues[0].id}"
    end

    it 'responds with no content' do
      expect(response.body).to eq ''
      expect(response.status).to eq 204
    end
  end
end

