class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


  def record_not_found
    render json: {error: 'Record not found'}, status: :not_found
  end

  def authorize_request
    header = request.headers['Authorization']  # Correct way to access headers
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e  # Corrected typo here
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e  # Use the correct variable for the exception
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::VerificationError => e  # Handle JWT verification failure
      render json: { error: 'Invalid token or signature' }, status: :unauthorized
    end
  end

end
