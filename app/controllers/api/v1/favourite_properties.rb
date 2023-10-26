module API
  module V1
    class FavouriteProperties < Grape::API
      include API::V1::Defaults
      helpers AuthHelper

      before do
        authenticate!
      end

      resource :favourite_properties do
        desc "Create a favourite property"
        params do
          requires :user_id, type: Integer, desc: "User ID"
          requires :property_id, type: Integer, desc: "Property ID"
        end
        post do
          ensure_resource_action!
          FavouriteProperty.create!(params)
        end

        desc "Delete a favourite property"
        params do
          requires :id, type: String, desc: 'Favourtie Property ID.'
        end
        delete ":id" do
          fav_property = FavouriteProperty.find(params[:id])
          if fav_property
            ensure_resource_action!(fav_property.user)
            fav_property.destroy!
            status 204
            {}
          end
        end
      end
    end
  end
end