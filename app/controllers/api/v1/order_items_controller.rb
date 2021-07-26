class Api::V1::OrderItemsController < ApplicationController
  skip_before_action :authenticate_user!

  def create

    if user_signed_in?
      @order = current_user.order.create
    else 
      @order = Order.create
    end
    
    @order_item = OrderItem.new 
    @order_item.food_item_id = params[:order_item][:food_item_id]
    @order.order_items << @order_item
    
    if @order.save
      url = "/orders/#{@order.id}"
      render :js => "#{url}" 
    end
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :food_item_id)
    end
end