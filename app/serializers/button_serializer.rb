class ButtonSerializer < ActiveModel::Serializer
  attributes :id, :assignment, :created_at, :updated_at
  belongs_to :phone
  belongs_to :story
end