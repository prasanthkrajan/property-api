module API
  module V1
    class Properties < Grape::API
      include Grape::Kaminari
      include API::V1::Defaults
      helpers AuthHelper

      resource :properties do
        desc "Return all properties"
        params do
          use :pagination, per_page: 20, max_per_page: 30
        end
        get do
          properties = PropertySearchQuery.new(params).perform!
          paginate(properties)
        end

        desc "Return a property"
        params do
          requires :id, type: String, desc: "Property ID"
        end
        get ":id", root: "property" do
          Property.find(params[:id])
        end

        desc "Update a property"
        params do
          requires :id, type: String, desc: 'Property ID.'
          optional :property, type: Hash do
            optional :rent, type: BigDecimal 
            optional :full_address, type: String
            optional :unit_type, type: String
            optional :bedroom, type: Integer
            optional :bathroom, type: Integer
            optional :closest_mrt, type: String
            optional :floor_size_in_ping, type: BigDecimal
            optional :floor_size_in_sqft, type: BigDecimal
            optional :city, type: String
            optional :district, type: String
            optional :title, type: String
            optional :image_url, type: String
          end
        end
        put ":id" do
          authenticate!
          ensure_admin!
          property = Property.find(params[:id])
          if property
            property.update(declared(params)['property'])
            property
          end
        end

        desc "Delete a property"
        params do
          requires :id, type: String, desc: 'Property ID.'
        end
        delete ":id" do
          authenticate!
          ensure_admin!
          property = Property.find(params[:id])
          if property
            property.destroy!
            status 204
            {}
          end
        end
      end
    end
  end
end