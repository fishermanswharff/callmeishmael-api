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
    phone_stories = Story.connection.select_all("SELECT buttons.assignment, buttons.id, stories.id, stories.title, stories.created_at, stories.url FROM stories INNER JOIN buttons ON (buttons.story_id = stories.id) WHERE buttons.phone_id = #{object.id} ORDER BY buttons.assignment;").rows
    stories = phone_stories.each_with_object({}) { |i,o|
      o[i[0]] = { button_id: i[1], story_id: i[2], title: i[3], created_at: Date.parse(i[4]).strftime('%A, %D') , url: i[5] }
    }
  end
end