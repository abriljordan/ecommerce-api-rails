module Api
  module V1
    class CheckoutController < ApplicationController
      before_action :set_cart

      def create
        total_amount = @cart.cart_items.includes(:product).sum { |item| item.product.price * item.quantity }

        # Dummy payment processing
        if process_payment(total_amount)
          @cart.update(checked_out: true)
          render json: { message: "Payment successful", total: total_amount }, status: :ok
        else
          render json: { error: "Payment failed" }, status: :unprocessable_entity
        end
      end

      private

      def set_cart
        @cart = Cart.find(params[:cart_id])
      end

      def process_payment(amount)
        # Integrate Stripe/PayPal here
        true
      end
    end
  end
end
