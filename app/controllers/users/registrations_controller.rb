# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :password,:password_confirmation, :role)
  end
  def account_update_params
    params.require(:user).permit(:email, :password,:password_confirmation, :current_password, :role)
  end

  def respond_with(resource, options = {})
     if resource.persisted?
      register_success
     else
    register_failed
     end
  end

  def register_success
    render json: {
      status: {
      code: 200,
      message: 'Signed up sucessfully.',
      user: current_user }
    }, status: :ok
  end

  def register_failed
    render json: {
      status: {
        message: 'Something went wrong.'}
      }, status: :unprocessable_entity
  end
end
