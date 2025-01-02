module Api
  module V1
    class CartItemsController < ApplicationController
      before_action :set_cart

      def create
        item = @cart.cart_items.new(cart_item_params)
        if item.save
          render json: item, status: :created
        else
          render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        item = @cart.cart_items.find(params[:id])
        item.destroy
        head :no_content
      end

      private

      def set_cart
        @cart = Cart.find(params[:cart_id])
      end

      def cart_item_params
        params.require(:cart_item).permit(:product_id, :quantity)
      end
    end
  end
end
