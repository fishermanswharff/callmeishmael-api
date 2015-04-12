class UserSerializer < ActiveModel::Serializer
  attributes :id, :token, :firstname, :lastname, :username, :role, :email, :phonenumber, :active, :main_store_contact, :main_business_contact, :created_at, :updated_at
end