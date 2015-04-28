class PhoneSerializer < ActiveModel::Serializer
  attributes :id, :unique_identifier, :token, :status, :wifiSSID, :wifiPassword, :created_at, :updated_at
  belongs_to :venue
end