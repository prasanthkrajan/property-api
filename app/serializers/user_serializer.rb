class UserSerializer < ActiveModel::Serializer
  attributes :email,
  					 :auth_token,
  					 :admin,
  					 :id
end