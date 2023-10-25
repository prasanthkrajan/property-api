class PropertySerializer < ActiveModel::Serializer
  attributes :id, 
  					 :rent,
  					 :currency,
  					 :full_address,
  					 :unit_type,
  					 :bedroom,
  					 :bathroom,
  					 :closest_mrt,
  					 :floor_size_in_ping,
  					 :floor_size_in_sqft,
  					 :city,
  					 :district,
  					 :title,
  					 :image_url
end