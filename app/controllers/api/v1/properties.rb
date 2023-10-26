module API
  module V1
    class Properties < Grape::API
      include API::V1::Defaults
      helpers AuthHelper

      helpers do
        def sort_direction
          sort_order = params[:sort_order]&.downcase
          %w[asc desc].include?(sort_order) ? sort_order : 'asc'
        end

        def sort_column
          sort_by = params[:sort_by]&.downcase
          Property.column_names.include?(sort_by) ? sort_by : 'rent'
        end
      end

      resource :properties do
        desc "Return all properties"
        get "", root: :properties do
          PropertySearchQuery.new.perform(params).order(sort_column => sort_direction)
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