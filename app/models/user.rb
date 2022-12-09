class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end

# When a token is dispatched to a user, the JTI claim is taken from the JTI column in the model (which was initialized when the record had been created).
# At every authenticated action, the incoming token JTI claim is matched against the JTI column for that user. Authentication only succeeds if they are the same.
# When the user requests to sign out, its JTI column changes, so that the provided token won't be valid anymore.
