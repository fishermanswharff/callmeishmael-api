class Phone < ActiveRecord::Base
  before_create :set_token
  after_save :set_unique_id
  belongs_to :venue, counter_cache: :number_phones
  has_many :buttons
  has_many :stories, through: :buttons
  enum status: [:active, :inactive, :retired, :fixable]

  private
  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/, '')
  end

  def set_unique_id
    self.unique_identifier = "#{self.venue.id}-#{self.id}"
  end
end