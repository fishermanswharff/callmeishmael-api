# == Schema Information
#
# Table name: phonelogs
#
#  id          :integer          not null, primary key
#  log_content :text
#  phone_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Phonelog, type: :model do

  before(:all) do
    @log = FactoryGirl.create(:phonelog)
  end

  it 'has log_content' do
    expect(@log.log_content).not_to eq nil
    expect(@log.log_content).to be_a String
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

  it 'parses the log after creation and notifies the stories' do
    expect(Button.where(phone_id: @log.phone.id, assignment: '8').first.story.listens).to eq 9
    expect(Button.where(phone_id: @log.phone.id, assignment: '7').first.story.listens).to eq 1
  end

  it 'parses the log after creation and notifies the venue' do
    total_listens = @log.match_listens.count
    expect(@log.phone.venue.total_listens).to eq total_listens
    expect(@log.phone.venue.total_listens).to eq 10
  end

end
