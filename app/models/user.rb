class User < ActiveRecord::Base

  has_and_belongs_to_many :venues

  before_create :set_token
  validates :firstname, :lastname, :role, :email, presence: true
  validates :phonenumber, numericality: { only_integer: true }
  validates :email, uniqueness: true

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