class UserSerializer < ActiveModel::Serializer
  attributes :id, :token, :firstname, :lastname, :username, :role, :email, :phonenumber, :active, :main_store_contact, :main_business_contact, :confirmed, :created_at, :updated_at

  def created_at
    object.created_at.strftime('%Y-%m-%d')
  end
  def updated_at
    object.updated_at.strftime('%Y-%m-%d')
  end
end