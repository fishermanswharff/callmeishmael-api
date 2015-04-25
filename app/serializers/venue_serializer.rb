class VenueSerializer < ActiveModel::Serializer
  attributes :id, :unique_identifier, :name, :status, :number_phones, :post_roll_listens, :total_stories, :created_at, :updated_at
  belongs_to :user

  def created_at
    object.created_at.strftime('%Y-%m-%d')
  end

  def updated_at
    object.updated_at.strftime('%Y-%m-%d')
  end

  def status
    object.status ? 'active' : 'paused'
  end
end