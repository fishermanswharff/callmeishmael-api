class Phonelog < ActiveRecord::Base
  belongs_to :phone
  validates :log_content, presence: true
  validates_associated :phone

  def match_listens
    matches = self.log_content.scan(/((?:\d{4})\-(?:\d{2})\-(?:\d{2})[\s]{1}(?:[\d\:\,]+))(?:.+ detects button push)([\d\*\#]|PR)/)
  end

  def notify_stories(array)
    array.map { |a| Button.where(phone_id: self.id, assignment: a[1]).first.story.increment_listens }
  end

  # when a log comes in, i need to check for a line that looks like this:
  # 2015-07-08 17:33:57,132 Event: HWListener detects button push8
  # find the corresponding story assigned to button 8 of that phone
  # increase the story count on that story
  # increment the total listens on the venue associated with that phone by 1
end