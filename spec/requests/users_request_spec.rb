require 'rails_helper'
require 'spec_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe 'User API Endpoint' do
  before(:each) do
    User.destroy_all
    @admin_user = User.create({
      firstname: 'foo',
      lastname: 'bar',
      phonenumber: 6173889520,
      username: 'foobar',
      role: 'admin',
      email: 'foo@bar.com',
      password: 'secret',
    })
  end

  describe '#login' do
    before(:each) do
      post '/login',{ email: "foo@bar.com", password: "secret" }
    end

    it 'has valid authentication with token' do
      expect(response.status).to eq 202
    end

    it 'responds with valid JSON' do
      expect(response.content_type).to eq Mime::JSON
    end

    it 'refuses invalid authentication' do
      post '/login',{ email: "foo@bar.com", password: "bar" }
      expect(response.status).to eq 401
    end

    it 'expects a token in the response' do
      user = json(response.body)
      expect(user).to_not be_nil
    end

    it 'responds 401 if unauthorized' do
      post '/login', { email: "foo@bar.com", password: "fakesecret"}
      expect(response.status).to eq 401
    end
  end

  describe '#logout' do
    before(:each) do
      post '/login',{ email: "foo@bar.com", password: "secret" }
      get '/logout'
    end
    it 'logs the user out' do
      expect(response.status).to eq 200
    end
    it 'returns only a response header' do
      expect(response.body).to eq ""
    end
  end

  describe '#index' do
    it 'retrieves all of the users' do
      get '/admin/users'
      expect(response).to be_success
    end

    it 'returns valid json' do
      get '/admin/users'
      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
    end
  end

  describe '#show' do
    before(:each) do
      get "/admin/users/#{@admin_user.id}"
    end

    it 'retrieves one user' do
      expect(response.status).to eq 200
    end

    it 'responds with valid JSON' do
      expect(response.content_type).to eq Mime::JSON
    end

    it 'returns the correct user information' do
      user_response = json(response.body)
      expect(user_response[:username]).to eq 'foobar'
    end
  end

  describe '#create' do

    before(:each) do
      post '/admin/users',
      { user:
        { firstname: 'far', lastname: 'boo', username: 'farboo', phonenumber: 6173889520, role: 'venue_admin', email: 'foz@baz.com', password: 'secret'}
      }.to_json, {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@admin_user.token}" }
    end

    it 'creates a new user' do
      expect(response.status).to eq 201
    end

    it 'returns the location of the user' do
      user = json(response.body)
      expect(admin_user_url(user[:id])).to eq response.location
    end

    it 'refuses without the proper parameters' do
      post '/admin/users',
      { user:
        { username: 12, email: '', password: '', name: 'jason', about: 'about me'}
      }.to_json, {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'HTTP_AUTHORIZATION' => "Token token=#{@admin_user.token}" }
      expect(response.status).to eq 422
    end
  end

  describe '#update' do
    before(:each) do
      patch "/admin/users/#{@admin_user.id}",
      { user:
        { firstname: 'jason', lastname: 'wharff', role: 'admin', password: 'secret' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      @admin_user_response = json(response.body)
    end

    it 'responds with success' do
      expect(response.status).to eq 200
    end

    it 'updates only the new params' do
      expect(@admin_user_response[:firstname]).to eq 'jason'
    end

    it 'doesn''t update any other params' do
      expect(@admin_user_response[:username]).to eq 'foobar'
    end
  end

  describe '#destroy' do
    it 'deletes existing user' do
      delete "/admin/users/#{@admin_user.id}", {}, { 'HTTP_AUTHORIZATION' => "Token token=#{@admin_user.token}" }
      expect(response.status).to eq 204
    end
  end
end

























