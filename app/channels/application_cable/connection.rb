require 'jwt'
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.params[:jwt].split(' ').last
      decoded_token = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY'])
      if (current_user = User.find_by_jti(decoded_token.first['jti']))
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end

# We have created a system that allows us to send information only to verified users while being especially careful not to provide any data of the users through our channels. 