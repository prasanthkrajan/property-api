class FavouriteProperty < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :property_id, 
  					uniqueness: { scope: [:user_id], message: 'is already favorited' }
end

