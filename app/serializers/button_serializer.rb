# == Schema Information
#
# Table name: buttons
#
#  id         :integer          not null, primary key
#  assignment :text             not null
#  phone_id   :integer
#  story_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

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
