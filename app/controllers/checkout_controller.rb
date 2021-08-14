class CheckoutController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @order = Order.find(params[:order_id])
    @food_items = @order.order_items.map do |order_item|
      food_item = order_item.food_item
      { price: food_item.stripe_price_id, quantity: order_item.quantity }
    end
    user = current_user || guest_user
    @session = Stripe::Checkout::Session.create({
      customer: user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: @food_items,
      mode: 'payment',
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url,
    })
    respond_to do |format|  
      format.json
    end
  end

  def success
    if params[:session_id].present?
      current_order.update(status: "ordered")
      @session_with_expand =  Stripe::Checkout::Session.retrieve({ 
        id: params[:session_id],
        expand: ["line_items"]
      })
      reset_current_order
    else
      redirect_to cancel_url, alert: "Nothing to dispaly"
    end
  end

  def cancel

  end

  def reset_current_order 
    session.delete(:order_id)
    current_order = nil;
  end
end