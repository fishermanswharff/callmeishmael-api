class User < ActiveRecord::Base
  before_create :set_token
  validates :firstname, :lastname, :role, :email, presence: true
  validates :phonenumber, numericality: { only_integer: true }
  enum role: [:admin, :venue_admin]
  has_secure_password

  private
  def set_token
    return if token.present?
    self.token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/, '')
  end
end