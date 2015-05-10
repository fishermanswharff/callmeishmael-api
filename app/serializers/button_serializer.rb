class ButtonSerializer < ActiveModel::Serializer
  attributes :id, :assignment, :created_at, :updated_at
  belongs_to :phone
  belongs_to :story

  def created_at
    object.created_at.strftime('%A, %D')
  end
  def updated_at
    object.updated_at.strftime('%A, %D')
  end
end