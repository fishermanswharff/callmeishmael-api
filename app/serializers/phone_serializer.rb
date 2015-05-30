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
    phone_stories = Story.connection.select_all("SELECT buttons.assignment, stories.title, stories.created_at, stories.url FROM stories INNER JOIN buttons ON (buttons.story_id = stories.id) WHERE buttons.phone_id = #{object.id} ORDER BY buttons.assignment;").rows
    stories = phone_stories.each_with_object({}) { |i,o|
      o[i[0]] = { title: i[1], created_at: i[2], url: i[3] }
    }
  end
end