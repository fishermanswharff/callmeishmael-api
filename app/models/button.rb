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

  before_validation :only_unique_assignments_on_update, on: [:update]
  validates_associated :phone
  validates_associated :story
  validates :assignment, presence: true
  validates :assignment, inclusion: { in: ['*','#','0','1','2','3','4','5','6','7','8','9','PR'] }
  validate :there_can_only_be_one_post_roll
  validate :only_unique_assignments

  private

  def there_can_only_be_one_post_roll
    true
  end

  def only_unique_assignments
    matches = phone.buttons.map { |b| b if b.assignment == assignment && b != self }.compact
    errors.add(:assignment, 'There is already a button with that assignment. Please update button rather than creating a new one.') if matches.length > 0
  end

  protected

  def only_unique_assignments_on_update
    # destroy the button that had the same assignment
    matches = phone.buttons.map { |b| Button.destroy(b.id) if b.assignment == assignment }.compact
    phone.reload
  end

end
