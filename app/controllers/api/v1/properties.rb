module API
  module V1
    class Properties < Grape::API
      include API::V1::Defaults

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
          Property.order(sort_column => sort_direction)
        end

        # desc "Return a graduate"
        # params do
        #   requires :id, type: String, desc: "ID of the 
        #     graduate"
        # end
        # get ":id", root: "graduate" do
        #   Graduate.where(id: permitted_params[:id]).first!
        # end
      end
    end
  end
end