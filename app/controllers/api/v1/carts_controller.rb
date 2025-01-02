module Api
  module V1
    class CartsController < ApplicationController
      before_action :set_cart, only: %i[show destroy checkout] # Add checkout here

      def index
        carts = Cart.where(user: current_user)
        render json: carts
      end

      def show
        render json: @cart, include: :cart_items
      end

      def create
        cart = current_user.carts.build
        if cart.save
          render json: cart, status: :created
        else
          render json: cart.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @cart.destroy
        head :no_content
      end

      # Add the checkout action
      def checkout
        if @cart.cart_items.any?
          # Example logic: Mark cart as checked out, reduce stock, etc.
          @cart.update(checked_out: true)
          render json: { message: "Checkout successful" }, status: :ok
        else
          render json: { error: "Cart is empty" }, status: :unprocessable_entity
        end
      end

      private

      def set_cart
        @cart = current_user.carts.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Cart not found" }, status: :not_found
      end
    end
  end
end
