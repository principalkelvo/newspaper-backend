class ApplicationController < ActionController::API
    respond_to :json
include ActionController::MimeResponds

#?code not working because of authentication token
#?check connection.rb

# With this method we will be able to extract the token for each request headers and verify it with the logged in use
# include Response
#  include ExceptionHandler
#  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
#  def authenticate_request!
#    return invalid_authentication if !payload || !AuthenticationTokenService.valid_payload(payload.first)
#    current_user!
#    invalid_authentication unless @current_user
#  end
#  def current_user!
#    @current_user = User.find_by(id: payload[0]['user_id'])
#  end
#  private
#  def payload
#    auth_header = request.headers['Authorization']
#    token = auth_header.split(' ').last
#    AuthenticationTokenService.decode(token)
#  rescue StandardError
#    nil
#  end
#  def invalid_authentication
#    render json: { error: 'You will need to login first' }, status: :unauthorized
#  end
end
