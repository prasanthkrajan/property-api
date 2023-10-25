module API
  module V1
    class Properties < Grape::API
      include API::V1::Defaults

      resource :properties do
        desc "Return all properties"
        get "", root: :properties do
          Property.all
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