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