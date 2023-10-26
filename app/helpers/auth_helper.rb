module AuthHelper
	def authenticate!
    error!('Unauthorized. Invalid or expired token.', 401) unless current_user
  end

  def current_user
    auth_token = headers['Authorization'].to_s.split(' ').last
    return unless auth_token

    decoded_auth_token = JsonWebToken.decode(auth_token)
    return unless decoded_auth_token

    User.find_by(id: decoded_auth_token['user_id'])
  end

  def ensure_resource_action!(user = nil)
  	context_user_id = params[:user_id] || user&.id
  	return true unless context_user_id

  	error!('Forbidden. Not allowed', 403) unless context_user_id == current_user.id
  end
end