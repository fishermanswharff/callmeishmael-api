require 'rails_helper'

RSpec.describe 'Stories API Endpoint' do

  before(:all) do
    # create a bunch of stories
  end

  describe '#index' do
    before(:each) do
      get '/stories'
    end

    it 'responds successfully' do
      expect(response.status).to eq 200
    end
  end

  describe '#show' do
    before(:each) do
      get "/stories/#{@stories[0].id}"
    end
  end
end