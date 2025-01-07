class ApplicationController < ActionController::API
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  # Access the currently authenticated user
  def current_user
    @current_user
  end

  # Respond with an unauthorized error
  def unauthorized(message = "Unauthorized")
    render json: { error: message }, status: :unauthorized
  end

  # Respond with a not-found error
  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  # Authenticate the user before any action
  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    if token && decode_token(token)
      @current_user = User.find(@decoded_token["user_id"])
    else
      unauthorized
    end
  end

  # Decode and verify the JWT token
  def decode_token(token)
    @decoded_token ||= JWT.decode(
      token,
      Rails.application.secret_key_base,
      true,
      { algorithm: "HS256" }
    ).first
  rescue JWT::ExpiredSignature
    unauthorized("Token has expired")
    nil
  rescue JWT::DecodeError => e
    Rails.logger.debug("JWT Decode Error: #{e.message}")
    nil
  end
end
