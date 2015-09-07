# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  firstname              :text
#  lastname               :text
#  username               :text
#  role                   :integer          default(1), not null
#  email                  :text
#  phonenumber            :integer
#  password_digest        :string
#  token                  :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  active                 :boolean          default(TRUE)
#  main_store_contact     :boolean          default(FALSE)
#  main_business_contact  :boolean          default(FALSE)
#  confirmed              :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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
