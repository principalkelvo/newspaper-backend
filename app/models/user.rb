class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  def jwt_payload
    super
  end


  # creates user roles 
  enum role:[:user, :moderator, :admin]
    after_initialize :set_default_role, :if => :new_record?
    def set_default_role
      self.role ||= :user
    end
end

# When a token is dispatched to a user, the JTI claim is taken from the JTI column in the model (which was initialized when the record had been created).
# At every authenticated action, the incoming token JTI claim is matched against the JTI column for that user. Authentication only succeeds if they are the same.
# When the user requests to sign out, its JTI column changes, so that the provided token won't be valid anymore.
