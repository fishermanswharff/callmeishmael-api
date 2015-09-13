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
#

class Venue < ActiveRecord::Base
  after_create :set_unique_id
  has_and_belongs_to_many :users
  has_many :phones
  has_many :venuestories
  has_many :stories, through: :venuestories

  def set_unique_id
    self.unique_identifier = "#{self.id}-#{SecureRandom.uuid.gsub(/\-/, '')}"
    self.save!
  end

  def increment_listens(amount)
    self.total_listens += amount
  end
end
