# == Schema Information
#
# Table name: venuestories
#
#  id         :integer          not null, primary key
#  venue_id   :integer
#  story_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Venuestory < ActiveRecord::Base
  belongs_to :venue
  belongs_to :story

  validates_associated :venue
  validates_associated :story
end
