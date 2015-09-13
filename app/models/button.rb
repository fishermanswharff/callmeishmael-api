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

class Button < ActiveRecord::Base
  belongs_to :phone
  belongs_to :story, counter_cache: :placements

  validates_associated :phone
  validates_associated :story
  validates :assignment, presence: true
  validates :assignment, inclusion: { in: ['*','#','0','1','2','3','4','5','6','7','8','9','PR'] }

end
