class Phone < ActiveRecord::Base
  before_create :set_token
  after_create :set_unique_id
  belongs_to :venue, counter_cache: :number_phones
  has_many :buttons
  has_many :stories, through: :buttons
  enum status: [:active, :inactive, :retired, :fixable]

  def set_unique_id
    if self.venue
      self.unique_identifier = "#{self.venue.id}-#{self.id}"
      self.save!
    end
  end

  private
  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/, '')
  end
end