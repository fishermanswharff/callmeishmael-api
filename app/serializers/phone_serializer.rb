class PhoneSerializer < ActiveModel::Serializer
  attributes :id, :unique_identifier, :token, :status, :wifiSSID, :wifiPassword, :created_at, :updated_at
  belongs_to :venue
  has_many :stories

  def created_at
    object.created_at.strftime('%A, %D')
  end
  def updated_at
    object.updated_at.strftime('%A, %D')
  end
end