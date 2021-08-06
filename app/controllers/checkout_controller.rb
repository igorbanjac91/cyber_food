class CheckoutController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @order = Order.find(params[:order_id])
    @food_items = @order.order_items.map do |order_item|
      food_item = order_item.food_item
      { price: food_item.stripe_price_id, quantity: order_item.quantity }
    end
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
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
    @session_with_expand =  Stripe::Checkout::Session.retrieve({ 
      id: params[:session_id],
      expand: ["line_items"]
    })
    @session_with_expand.line_items.data.each do |line_item|
      food_item = FoodItem.find_by(stripe_product_id: line_item.price.product)
    end
  end

  def cancel

  end
end