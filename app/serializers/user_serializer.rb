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

class UserSerializer < ActiveModel::Serializer
  attributes :id, :token, :firstname, :lastname, :username, :role, :email, :phonenumber, :active, :main_store_contact, :main_business_contact, :confirmed, :created_at, :updated_at
  has_many :venues

  def created_at
    object.created_at.strftime('%A, %D')
  end
  def updated_at
    object.updated_at.strftime('%A, %D')
  end
end
