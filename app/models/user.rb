require "jwt"

class User < ApplicationRecord
  has_many :carts

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :name, presence: true
  def generate_jwt
    expiration = 24.hours.from_now.to_i
    payload = { user_id: id, exp: expiration }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
