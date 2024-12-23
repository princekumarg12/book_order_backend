module Api
  module V1
    class AuthController < ApplicationController
      def login
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password]) # Use bcrypt's authenticate method
          token = encode_token(user_id: user.id) # Encode the token
          render json: {token: token}, status: :ok
        else
          render json: {error: 'Invalid credentials'}, status: :unauthorized
        end
      end

      # POST /logout
      def logout
        # You can choose to invalidate the token in a centralized store or rely on expiration
        render json: {message: 'Logged out successfully'}, status: :ok
      end

      private

      # Method to generate JWT token
      def encode_token(payload)
        JWT.encode(payload, Rails.application.credentials.jwt_secret, 'HS256') # Use a secret from environment variables
      end
    end
  end
end


