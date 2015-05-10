class Venue < ActiveRecord::Base
  after_create :set_unique_id
  has_and_belongs_to_many :users
  has_many :phones

  def set_unique_id
    self.unique_identifier = "#{self.id}-1000"
    self.save!
  end
end