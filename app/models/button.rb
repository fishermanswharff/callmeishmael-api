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

  VALID_PLACEMENTS = ['*','#','0','1','2','3','4','5','6','7','8','9','PR','none']

  belongs_to :phone
  belongs_to :story, counter_cache: :placements

  validates_associated :phone, unless: :is_postroll?
  validates_associated :story
  validates :assignment, presence: true
  validates :assignment, inclusion: { in: VALID_PLACEMENTS }
  validate :unique_assignments, on: [:create]
  validate :is_postroll_story?, if: :is_postroll?
  validate :is_fixed_story?, if: :is_fixed_assignment?

  before_save :remove_assignment, on: [:update], if: :assignment_exists_on_phone?, unless: :is_postroll_or_fixed?

  scope :by_assignment, -> (assignment) { where("assignment = ?", assignment) }
  scope :postroll_assignments, -> { where(assignment: 'PR') }
  scope :inactive_assignments, -> { where(assignment: 'none') }
  scope :fixed_assignments, -> { where("assignment = '*' OR assignment = '#' OR assignment = '0'") }
  scope :star_assignments, -> { where(assignment: '*') }
  scope :hash_assignments, -> { where(assignment: '#') }
  scope :zero_assignments, -> { where(assignment: '0') }

  def self.assign_story_by_assignment(story, assignment)
    by_assignment(assignment).map { |button| button.update(story: story) }
  end

  # PRIVATE METHODS
  # —————————————————————————————————————————————
  private

  def unique_assignments
    matches = phone.buttons.map { |button| button if button.assignment == assignment && button != self }.compact
    errors.add(:assignment, 'There is already a button with that assignment. Please update button rather than creating a new one.') if matches.length > 0
  end

  def assignment_exists_on_phone?
    Button.where(phone_id: self.phone.id, assignment: self.assignment).length > 0
  end

  def is_postroll?
    assignment == 'PR'
  end

  def is_postroll_story?
    story.postroll?
  end

  def is_fixed_assignment?
    assignment == '*' || assignment == '#' || assignment == '0'
  end

  def is_fixed_story?
    story.fixed?
  end

  def is_postroll_or_fixed?
    is_postroll? || is_fixed_assignment?
  end

  def remove_assignment
    phone.buttons.map { |button| button.update(assignment: 'none') if button.assignment == assignment && button != self }
  end

end
