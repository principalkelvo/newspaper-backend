# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController

  private

  def respond_with( resource, options= {})
    render json: {
      status: {code: 200, message: 'You are logged in.', user: current_user}      
      
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:devise_jwt_secret)).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      log_out_success
    else
      log_out_failure
    end
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  end
end
