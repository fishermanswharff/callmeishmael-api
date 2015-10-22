# == Schema Information
#
# Table name: stories
#
#  id                :integer          not null, primary key
#  unique_identifier :text
#  title             :text             not null
#  url               :text             not null
#  story_type        :integer          default(1), not null
#  author_last       :text
#  author_first      :text
#  placements        :integer          default(0), not null
#  listens           :integer          default(0), not null
#  percentage        :decimal(4, 2)
#  created_at        :datetime
#  updated_at        :datetime
#  call_length       :string
#  common_title      :string
#  call_date         :date
#  spoiler_alert     :boolean          default(FALSE), not null
#  child_appropriate :boolean          default(TRUE), not null
#  explicit          :boolean          default(FALSE), not null
#  gender            :string           default("Female"), not null
#  rating            :integer          default(1), not null
#  transcript_url    :string
#  call_uuid         :integer
#

class StorySerializer < ActiveModel::Serializer
  attributes :id, :unique_identifier, :title, :url, :story_type,
             :author_first, :author_last, :placements, :listens,
             :percentage, :created_at, :updated_at, :call_length,
             :common_title, :call_date, :spoiler_alert, :child_appropriate,
             :explicit, :gender, :rating, :current_placements, :md5_url
  has_many :phones
  has_many :venues

  def created_at
    object.created_at.strftime('%A, %D')
  end

  def updated_at
    object.updated_at.strftime('%A, %D')
  end

  def current_placements
    object.phones.count
  end
end
