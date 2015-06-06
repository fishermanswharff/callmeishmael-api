class Story < ActiveRecord::Base
  has_many :buttons
  after_create :set_unique_id
  has_many :phones, through: :buttons
  enum story_type: [:fixed, :venue, :surprise, :ishmaels, :postroll]

  def set_unique_id
    self.unique_identifier = "#{self.id}-1000"
    self.save!
  end
end