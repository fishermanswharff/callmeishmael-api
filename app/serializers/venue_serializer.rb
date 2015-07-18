class VenueSerializer < ActiveModel::Serializer
  attributes :id, :unique_identifier, :name, :status, :number_phones, :post_roll_listens, :total_stories, :created_at, :updated_at
  has_many :users
  has_many :stories

  def created_at
    object.created_at.strftime('%A, %D')
  end

  def updated_at
    object.updated_at.strftime('%A, %D')
  end

  def status
    object.status ? 'active' : 'paused'
  end

  def total_stories
    # object.phones.map { |phone| phone.stories.count }.reduce(:+)
    object.stories.count
  end
end