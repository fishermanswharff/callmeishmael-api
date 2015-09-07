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
end
