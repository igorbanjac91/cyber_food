class CheckoutController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @order = Order.find(params[:order_id])
    @food_item = @order.order_items[0].food_item
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: [{
        price: @food_item.stripe_price_id,
        quantity: 1
      }],
      mode: 'payment',
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url,
    })
    respond_to do |format|  
      format.json
    end
  end

  def success

  end

  def cancel

  end
end