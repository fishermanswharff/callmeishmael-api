class StorySerializer < ActiveModel::Serializer
  attributes :id, :unique_identifier, :title, :url, :story_type, :author_first, :author_last, :placements, :listens, :percentage, :created_at, :updated_at
  has_many :phones

  def created_at
    object.created_at.strftime('%A, %D')
  end
  def updated_at
    object.updated_at.strftime('%A, %D')
  end
end