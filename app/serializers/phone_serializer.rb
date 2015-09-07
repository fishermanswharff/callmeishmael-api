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

class PhoneSerializer < ActiveModel::Serializer
  attributes :id, :unique_identifier, :token, :status, :wifiSSID, :wifiPassword, :created_at, :updated_at, :buttons
  belongs_to :venue
  has_many :stories

  def created_at
    object.created_at.strftime('%A, %D')
  end

  def updated_at
    object.updated_at.strftime('%A, %D')
  end

  def buttons
    phone_stories = Story.connection.select_all("SELECT buttons.assignment, buttons.id, stories.id, stories.title, stories.created_at, stories.url, stories.listens FROM stories INNER JOIN buttons ON (buttons.story_id = stories.id) WHERE buttons.phone_id = #{object.id} ORDER BY buttons.assignment;").rows
    stories = phone_stories.each_with_object({}) { |i,o|
      o[i[0]] = { button_id: i[1], story_id: i[2], title: i[3], created_at: Date.parse(i[4]).strftime('%A, %D') , url: i[5], listens: i[6] }
    }
    array = []
    array[0] = { '1' => stories['1'] }
    array[1] = { '2' => stories['2'] }
    array[2] = { '3' => stories['3'] }
    array[3] = { '4' => stories['4'] }
    array[4] = { '5' => stories['5'] }
    array[5] = { '6' => stories['6'] }
    array[6] = { '7' => stories['7'] }
    array[7] = { '8' => stories['8'] }
    array[8] = { '9' => stories['9'] }
    array[9] = { '0' => stories['0'] }
    array[10] = { '#' => stories['#'] }
    array[11] = { '*' => stories['*'] }
    array[12] = { 'PR' => stories['PR'] }
    array
  end
end
