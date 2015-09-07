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
#

class Story < ActiveRecord::Base
  after_create :set_unique_id
  has_many :buttons
  has_many :phones, through: :buttons
  has_many :venuestories
  has_many :venues, through: :venuestories
  enum story_type: [:fixed, :venue, :ishmaels, :postroll]

  validates :title, :url, :story_type, :author_last, :author_first, :placements,
            :listens, :call_length, :common_title, :call_date, :gender, :rating,
            presence: true

  validates :author_first, :author_last, length: { minimum: 2 }
  validates :call_length, format: { with: /[\d]{1,2}:[0-5](?:[0-9])/, message: 'Format required is 00:00 or 0:00' }
  validates :url, format: { with: /[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#\/\/\=]*)/, message: 'Must be a valid url.' }
  validates :child_appropriate, :explicit, :spoiler_alert, inclusion: { in: [true, false] }
  validates :rating, :placements, :listens, numericality: { only_integer: true }
  validates :gender, inclusion: { in: %w(Male Female) }
  validates_associated :venues, if: :associated_with_venue?
  validates_associated :phones, if: :assigned_to_button?
  validate :call_date_in_the_past

  def set_unique_id
    self.unique_identifier = "#{self.id}-1000"
    self.save!
  end

  def increment_listens
    self.listens += 1
    self.save!
    self.listens
  end

  private

  def call_date_in_the_past
    if call_date.present? && call_date > Date.today
      errors.add(:call_date, 'Can’t be in the future')
    end
  end

  def associated_with_venue?
    # short for self.story_type == 'venue'
    self.venue?
  end

  def assigned_to_button?
    buttons.length > 0
  end

end
