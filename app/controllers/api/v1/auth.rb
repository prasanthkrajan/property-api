module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults

      resource :auth do
        desc "Creates and returns access_token if valid login"
        params do
          requires :email, type: String, desc: "Email address of user"
          requires :password, type: String, desc: "Password"
        end
        post ':login' do
          user = User.find_by(email: params[:email])
          if user && user.valid_password?(params[:password])
            user.auth_token = JsonWebToken.encode(user_id: user.id)
            user
          else
            error!('Unauthorized.', 401)
          end
        end

        # desc "Creates a new user and returns access token"
        # params do
        #   requires :email, type: String, desc: "Email address of user"
        #   requires :password, type: String, desc: "Password"
        # end
        # post ':register' do
        #   user = User.create!(params)
        #   if user
        #     user.auth_token = JsonWebToken.encode(user_id: user.id)
        #     user
        #   end
        # end
      end
    end
  end
end