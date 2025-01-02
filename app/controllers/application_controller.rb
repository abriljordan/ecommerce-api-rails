class ApplicationController < ActionController::API
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
  def current_user
    @current_user
  end

  def unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    if token && decode_token(token)
      @current_user = User.find(@decoded_token["user_id"])
    else
      unauthorized
    end
  end

  def decode_token(token)
    Rails.logger.debug("Decoding token: #{token}")
    @decoded_token ||= JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: "HS256" }).first
  rescue JWT::ExpiredSignature
    unauthorized
  rescue JWT::DecodeError
    Rails.logger.debug("Debug error: #{e.message}")
    nil
  end
end
