module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: [ :create ]

      def create
        # Check if current_user is an admin and create a user with the given admin role
        if current_user&.admin? || !params.dig(:user, :admin)
          user = User.new(user_params)
        else
          user = User.new(user_params.except(:admin))
        end

        if user.save
          token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base)
          render json: { user: user, token: token }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
      end
    end
  end
end
