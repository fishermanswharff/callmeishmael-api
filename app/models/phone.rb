class Phone < ActiveRecord::Base
  before_create :set_token
  belongs_to :venue, counter_cache: :number_phones
  enum status: [:active, :inactive, :retired, :fixable]

  private
  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/, '')
  end
end