class CheckoutController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @order = Order.find(params[:order_id])
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id
      payment_method_types: ['card'],
      line_items: [{
        name: "Order id: #{@order.id}",
        quantity: 1,
        amount: @order.total,
        currency: "usd"
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    })
    respond_to do |format|  
      format.json
    end
  end
end