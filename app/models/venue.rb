class Venue < ActiveRecord::Base
  after_create :set_unique_id
  belongs_to :user, dependent: :destroy
  has_many :phones

  def set_unique_id
    self.unique_identifier = "#{self.id}-1000"
    self.save!
  end
end