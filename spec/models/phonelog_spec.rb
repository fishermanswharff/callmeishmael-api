require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Phonelog, type: :model do

  before(:each) do
    @log = FactoryGirl.create(:phonelog)
  end

  it 'has log_content' do
    expect(@log.log_content).not_to eq nil
  end

  it 'belongs to a phone' do
    expect(@log.phone).not_to be nil
    expect(@log.phone).to be_a Phone
  end

  it 'parses the log_content for listens on a story' do
    expect(@log.match_listens).to eq [["2015-07-08 17:33:57,132", "8"],
                                      ["2015-07-08 17:33:57,132", "8"],
                                      ["2015-07-08 17:33:57,132", "8"],
                                      ["2015-07-08 17:33:57,132", "8"],
                                      ["2015-07-08 17:33:57,132", "8"],
                                      ["2015-07-08 17:33:57,132", "8"],
                                      ["2015-07-08 17:33:57,132", "8"],
                                      ["2015-07-08 17:33:57,132", "8"],
                                      ["2015-07-08 17:33:57,132", "8"],
                                      ["2015-07-08 16:49:28,136", "7"]]
  end

  it 'finds the stories associated with the buttons' do
    matches = [["2015-07-08 17:33:57,132", "8"], ["2015-07-08 17:33:57,132", "8"], ["2015-07-08 17:33:57,132", "8"], ["2015-07-08 17:33:57,132", "8"], ["2015-07-08 17:33:57,132", "8"], ["2015-07-08 17:33:57,132", "8"], ["2015-07-08 17:33:57,132", "8"], ["2015-07-08 17:33:57,132", "8"], ["2015-07-08 17:33:57,132", "8"], ["2015-07-08 16:49:28,136", "7"]]
    response = @log.notify_stories(matches)
    expect(response).to be_a Array
    expect(response).to eq [1,2,3,4,5,6,7,8,9,1]
    expect(Button.where(phone_id: @log.phone.id, assignment: '8').first.story.listens).to eq 9
  end

end