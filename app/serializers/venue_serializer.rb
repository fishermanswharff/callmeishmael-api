# == Schema Information
#
# Table name: venues
#
#  id                :integer          not null, primary key
#  unique_identifier :text
#  name              :text             not null
#  status            :boolean          default(TRUE)
#  number_phones     :integer          default(0), not null
#  post_roll_listens :integer          default(0), not null
#  total_stories     :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  total_listens     :integer          default(0), not null
#  venue_status      :integer          default(0), not null
#

class VenueSerializer < ActiveModel::Serializer
  attributes :id, :unique_identifier, :name, :venue_status, :number_phones, :post_roll_listens, :total_stories, :created_at, :updated_at, :total_listens
  has_many :users
  has_many :stories

  def created_at
    object.created_at.strftime('%A, %D')
  end

  def updated_at
    object.updated_at.strftime('%A, %D')
  end

  def total_stories
    # object.phones.map { |phone| phone.stories.count }.reduce(:+)
    object.stories.count
  end
end
