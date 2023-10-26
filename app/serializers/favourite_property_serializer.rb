class FavouritePropertySerializer < ActiveModel::Serializer
  attributes :id, 
  					 :user_id,
             :property_id
end