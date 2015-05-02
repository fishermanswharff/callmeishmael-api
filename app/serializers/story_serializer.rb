class StorySerializer < ActiveModel::Serializer
  attributes :unique_identifier, :title, :url, :story_type, :author_first, :author_last, :placements, :listens, :percentage, :created_at, :updated_at
  has_many :phones
end